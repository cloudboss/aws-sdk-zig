pub const CreateScriptResponse = struct {
    /// The Python script generated from the DAG.
    python_script: ?[]const u8,

    /// The Scala code generated from the DAG.
    scala_code: ?[]const u8,

    pub const json_field_names = .{
        .python_script = "PythonScript",
        .scala_code = "ScalaCode",
    };
};
