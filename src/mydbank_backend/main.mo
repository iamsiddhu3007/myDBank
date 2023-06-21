import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  // var currentValue = 300;
  // currentValue := 500;

  stable var currentValue : Float = 300;
  //stable variable is a orthogonally persistant variable

  let id = 9249379838173498619834981;
  //let is immutable and doesnot change

  // Debug.print("Hello");
  // Debug.print(debug_show (currentValue));
  // Debug.print(debug_show (id));

  stable var startTime = Time.now();
  Debug.print(debug_show (startTime));

  public func topUp(amount : Float) {
    currentValue += amount;
    Debug.print(debug_show (currentValue));
  };

  public func withdraw(amount : Float) {
    let tempValue : Float = currentValue -amount;
    if (tempValue >= 0) {
      currentValue -= amount;
      Debug.print(debug_show (currentValue));
    } else {
      Debug.print("insufficient funds");
    };

  };

  public query func checkBalance() : async Float {
    return currentValue;
  };

  // topUp();

  public func compound() {
    let currentTime = Time.now();
    let timeElapsedNS = currentTime -startTime;
    let timeElapsedS = timeElapsedNS / 1000000000;
    currentValue := currentValue * (1.00001 ** Float.fromInt(timeElapsedS));
    startTime := currentTime;
  };

};
