/// Details from a successful operation
pub const BatchSuccessfulResultModel = struct {
    /// ARN of the resource
    arn: ?[]const u8,

    /// ID of the resource
    id: ?[]const u8,

    /// Current state of the resource
    state: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .state = "State",
    };
};
