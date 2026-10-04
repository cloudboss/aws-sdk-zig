/// Placeholder documentation for ListChannelsRequest
pub const ListChannelsRequest = struct {
    max_results: ?i32 = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
