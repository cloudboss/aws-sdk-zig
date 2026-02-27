/// Represents a request to the list projects operation.
pub const ListProjectsRequest = struct {
    /// Optional. If no Amazon Resource Name (ARN) is specified, then AWS Device
    /// Farm
    /// returns a list of all projects for the AWS account. You can also specify a
    /// project
    /// ARN.
    arn: ?[]const u8,

    /// An identifier that was returned from the previous call to this operation,
    /// which can
    /// be used to return the next set of items in the list.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .next_token = "nextToken",
    };
};
