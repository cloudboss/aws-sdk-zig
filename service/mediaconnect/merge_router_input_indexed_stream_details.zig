/// Configuration details for an indexed stream in a merge router input setup.
pub const MergeRouterInputIndexedStreamDetails = struct {
    /// The index number (0 or 1) assigned to this source in the merge
    /// configuration.
    source_index: i32,

    /// The IP address of the source for this indexed stream in the merge setup.
    source_ip_address: ?[]const u8 = null,

    pub const json_field_names = .{
        .source_index = "SourceIndex",
        .source_ip_address = "SourceIpAddress",
    };
};
