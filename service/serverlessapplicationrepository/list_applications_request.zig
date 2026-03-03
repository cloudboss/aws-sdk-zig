pub const ListApplicationsRequest = struct {
    /// The total number of items to return.
    max_items: ?i32 = null,

    /// A token to specify where to start paginating.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_items = "MaxItems",
        .next_token = "NextToken",
    };
};
