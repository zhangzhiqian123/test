package main
import(
    "encoding/json"
    "fmt"
    "time"
    "github.com/hyperledger/fabric/core/chaincode/shim"
    pb "github.com/hyperledger/fabric/protos/peer"
)
type cerChaincode struct{

}
type cerChain struct{
    StuTel      string `json:"stutel"`
    Organize    string `json:"organize"`
    CerName     string `json:"cername"`
    Student     string `json:"student"`
    Txid        string `json:"txid"`
    Timestamp   string `json:"timestamp"`
}
type cerKey struct{
    StuTel      string `json:"stutel"`
    Organize    string `json:"organize"`
    CerName     string `json:"cername"`
}

//=================================================
//Main
//=================================================
func main(){
    err:=shim.Start(new(cerChaincode))
    if err !=nil{
        fmt.Printf("Error starting simple chaincode:%s",err)
    }
}
func (t *cerChaincode) Init(stub shim.ChaincodeStubInterface) pb.Response{
    return shim.Success(nil)
}
//Init initializes chaincode
//============================
func (t *cerChaincode) Invoke(stub shim.ChaincodeStubInterface) pb.Response{
    function,args :=stub.GetFunctionAndParameters()
    fmt.Println("invoke is running"+function)

    //Handle different function
    if function =="createCer"{
        return t.createCer(stub,args)
    } else if function=="deleteCer"{
        return t.deleteCer(stub,args)
    }else if function =="queryCer"{
        return t.queryCer(stub,args)
    }

    fmt.Println("invoke did not find func:" + function)
    return shim.Error("recieved unknow function invocation")
}


//createCer --register a certificate to block chaincode
//key1 = SHA256 Hash ID
//value1 = copyright
//key2 = owner_userid
//value2 = transaction,asset +1
//====================================================

func (t *cerChaincode) createCer(stub shim.ChaincodeStubInterface,args []string) pb.Response{
    var certificate  cerChain;
    var cerkey       cerKey;

    if len(args) !=4{
        return shim.Error("createCer Incorrect number of arguments.")
    }

    cerkey.StuTel = args[0];
    cerkey.Organize = args[1];
    cerkey.CerName = args[2]
    fmt.Println("createCer after fill cerkey");
    chainkey,_ := json.Marshal(cerkey)
    tempStr :=string(chainkey)
    fmt.Println("createCer index is" +tempStr)

    valAsbytes,err :=stub.GetState(tempStr)
    if err !=nil{
        return shim.Error("certificate have existed")
    }else if valAsbytes != nil{
            return shim.Error("certificate have existed")
        }

    fmt.Println("createCer after check state");
    certificate.StuTel = args[0];
    certificate.Organize = args[1];
    certificate.CerName = args[2];
    certificate.Student = args[3];
    certificate.Txid = stub.GetTxID();
    timestamp,err :=stub.GetTxTimestamp()

    if err !=nil{
        return shim.Error("err.Error")
    }
    timestampstr := time.Unix(timestamp.Seconds,0).Format("2016-01-02 15:01:01")
    certificate.Timestamp = timestampstr;

    certificate.Timestamp ="2016-01-02"
    fmt.Println("createCer after  fill certificate boby");
    valAsbytes,err = json.Marshal(certificate)
    if err != nil{
        fmt.Println("createCer fail to call Marshal");
        return shim.Error(err.Error())
    }

    fmt.Println("createCer before put certificate to database");
    err = stub.PutState(tempStr,valAsbytes)
    if err !=nil{
        return shim.Error(err.Error())
    }
    fmt.Println("try create certificate:",tempStr,string(valAsbytes))
    return shim.Success(nil)
}


func (t *cerChaincode) queryCer(stub shim.ChaincodeStubInterface,args []string)pb.Response{
    var cerkey  cerKey;

    if len (args) !=3{
        return shim.Error("Incorrect number of arguments.3 args are expected")
    }

    cerkey.StuTel = args[0];
    cerkey.Organize = args[1];
    cerkey.CerName = args[2]

    chainkey,_ :=json.Marshal(cerkey)
    var tmpString string = string (chainkey[:]);
    valAsbytes,err :=stub.GetState(tmpString)
    if err != nil{
        fmt.Println("certificate :%s not exist.",tmpString)
        return shim.Error(err.Error())
    }else if valAsbytes !=nil{
        fmt.Println("exist certificate: --%s--%s",tmpString,string(valAsbytes))
    }
    return shim.Success(valAsbytes)
}

//deleteCer - delete the certificate from the chaincode
//key = buyer_userid
//value = transaction
//=====================================================

func (t *cerChaincode) deleteCer(stub shim.ChaincodeStubInterface,args []string)pb.Response{
    var cerkey cerKey;

    if len(args) !=3 {
        return shim.Error ("Incorrect number of arguments .3 args are expected")
    }

    cerkey.StuTel = args[0];
    cerkey.Organize = args[1];
    cerkey.CerName = args[2]
    chainkey,_:=json.Marshal(cerkey)
    tmpString :=string(chainkey);

    valAsbytes,err :=stub.GetState(tmpString)
    if err != nil{
        fmt.Println("certificate :%s not exist.",tmpString)
        return shim.Error(err.Error())
    }else if valAsbytes !=nil{
        fmt.Println("exist certificate: --%s--%s",tmpString,string(valAsbytes))
    }

    err = stub.DelState(tmpString)
    if err !=nil{
        return shim.Error(fmt.Sprintf("could not delete delta row: %s",err.Error()))
    }
    fmt.Println("try delete transaction: --%s--%s",tmpString,string(valAsbytes))
    return shim.Success(nil)
}
