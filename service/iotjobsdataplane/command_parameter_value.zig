/// The list of values used to describe a specific command parameter.
pub const CommandParameterValue = struct {
    /// An attribute of type Boolean. For example:
    ///
    /// `"BOOL": true`
    b: ?bool = null,

    /// An attribute of type Binary.
    bin: ?[]const u8 = null,

    /// An attribute of type Double (Sixty-Four Bits).
    d: ?f64 = null,

    /// An attribute of type Integer (Thirty-Two Bits).
    i: ?i32 = null,

    /// An attribute of type Long.
    l: ?i64 = null,

    /// An attribute of type String. For example:
    ///
    /// `"S": "Hello"`
    s: ?[]const u8 = null,

    /// An attribute of type Unsigned Long.
    ul: ?[]const u8 = null,

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
