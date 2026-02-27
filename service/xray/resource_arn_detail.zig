/// A list of resources ARNs corresponding to the segments in a trace.
pub const ResourceARNDetail = struct {
    /// The ARN of a corresponding resource.
    arn: ?[]const u8,

    pub const json_field_names = .{
        .arn = "ARN",
    };
};
