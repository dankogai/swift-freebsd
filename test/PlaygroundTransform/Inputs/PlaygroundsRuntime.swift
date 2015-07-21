// If you're modifying this file to add or modify function signatures, you
// should be notifying the maintainer of PlaygroundLogger and also the
// maintainer of lib/Sema/PlaygroundTransform.cpp.

class LogRecord {
  let text : String
  init(api : String, object : Any, name : String, id : Int) {
    var object_description : String = ""
    print(object, &object_description, appendNewline:false)
    text = api + "[" + name + "='" + object_description + "']"
  }
  init(api : String, object : Any, name : String) {
    var object_description : String = ""
    print(object, &object_description, appendNewline:false)
    text = api + "[" + name + "='" + object_description + "']"
  }
  init(api : String, object: Any) {
    var object_description : String = ""
    print(object, &object_description, appendNewline:false)
    text = api + "['" + object_description + "']"
  }
  init(api: String) {
    text = api
  }
}

func $builtin_log<T>(object : T, _ name : String) -> AnyObject? {
  return LogRecord(api:"$builtin_log", object:object, name:name)
}

func $builtin_log_with_id<T>(object : T, _ name : String, _ id : Int) -> AnyObject? {
  return LogRecord(api:"$builtin_log", object:object, name:name, id:id)
}

func $builtin_log_scope_entry() -> AnyObject? {
  return LogRecord(api:"$builtin_log_scope_entry")
}

func $builtin_log_scope_exit() -> AnyObject? {
  return LogRecord(api:"$builtin_log_scope_exit")
}

func $builtin_print<T>(object: T) -> AnyObject? {
  return LogRecord(api: "$builtin_print<>", object: object)
}

func $builtin_print<T, TargetStream : OutputStreamType>(object: T, inout _ stream: TargetStream) -> AnyObject? {
  return LogRecord(api: "$builtin_print<stream>", object: object)
}

func $builtin_print<T>(object: T, appendNewline: Bool) -> AnyObject? {
  if (appendNewline) {
    return LogRecord(api: "$builtin_print<appendNewline=true>", object: object)
  } else {
    return LogRecord(api: "$builtin_print<appendNewline=false>", object: object)
  }
}

func $builtin_print<T, TargetStream : OutputStreamType>(object: T, inout _ stream: TargetStream, appendNewline: Bool) -> AnyObject? {
  if (appendNewline) {
    return LogRecord(api: "$builtin_print<stream, appendNewline=true>", object: object)
  } else {
    return LogRecord(api: "$builtin_print<stream, appendNewline=false>", object: object)
  }
}

func $builtin_debugPrint<T>(object: T) -> AnyObject? {
  return LogRecord(api: "$builtin_debugPrint<>", object: object)
}

func $builtin_debugPrint<T, TargetStream : OutputStreamType>(object: T, inout _ stream: TargetStream) -> AnyObject? {
  return LogRecord(api: "$builtin_debugPrint<stream>", object: object)
}

func $builtin_debugPrint<T>(object: T, appendNewline: Bool) -> AnyObject? {
  if (appendNewline) {
    return LogRecord(api: "$builtin_debugPrint<appendNewline=true>", object: object)
  } else {
    return LogRecord(api: "$builtin_debugPrint<appendNewline=false>", object: object)
  }
}

func $builtin_debugPrint<T, TargetStream : OutputStreamType>(object: T, inout _ stream: TargetStream, appendNewline: Bool) -> AnyObject? {
  if (appendNewline) {
    return LogRecord(api: "$builtin_debugPrint<stream, appendNewline=true>", object: object)
  } else {
    return LogRecord(api: "$builtin_debugPrint<stream, appendNewline=false>", object: object)
  }
}

func $builtin_send_data(object:AnyObject?, _ sl: Int, _ el: Int, _ sc: Int, _ ec: Int) {
  let loc = "[\(sl):\(sc)-\(el):\(ec)]"
  print(loc + " " + (object as! LogRecord).text)
}
