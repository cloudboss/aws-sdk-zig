/// The result value of the command execution. The device can use the result
/// field to
/// share additional details about the execution such as a return value of a
/// remote function
/// call.
///
/// This field is not applicable if you use the `AWS-IoT-FleetWise`
/// namespace.
pub const CommandExecutionResult = struct {
    /// An attribute of type Boolean. For example:
    ///
    /// `"BOOL": true`
    b: ?bool = null,

    /// An attribute of type Binary.
    bin: ?[]const u8 = null,

    /// An attribute of type String. For example:
    ///
    /// `"S": "Hello"`
    s: ?[]const u8 = null,

    pub const json_field_names = .{
        .b = "B",
        .bin = "BIN",
        .s = "S",
    };
};
