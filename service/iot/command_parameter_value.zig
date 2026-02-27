/// The value of a command parameter used to create a command execution.
///
/// The `commandParameterValue` can only have one of the below fields
/// listed.
pub const CommandParameterValue = struct {
    /// An attribute of type Boolean. For example:
    ///
    /// `"BOOL": true`
    b: ?bool,

    /// An attribute of type Binary. For example:
    ///
    /// `"B": "dGhpcyB0ZXh0IGlzIGJhc2U2NC1lbmNvZGVk"`
    bin: ?[]const u8,

    /// An attribute of type Double (Sixty-Four Bits).
    d: ?f64,

    /// An attribute of type Integer (Thirty-Two Bits).
    i: ?i32,

    /// An attribute of type Long.
    l: ?i64,

    /// An attribute of type String. For example:
    ///
    /// `"S": "Hello"`
    s: ?[]const u8,

    /// An attribute of type unsigned long.
    ul: ?[]const u8,

    pub const json_field_names = .{
        .b = "B",
        .bin = "BIN",
        .d = "D",
        .i = "I",
        .l = "L",
        .s = "S",
        .ul = "UL",
    };
};
