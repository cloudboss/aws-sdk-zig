const InstanceSummary = @import("instance_summary.zig").InstanceSummary;

pub const ListInstancesResponse = struct {
    /// Information about the instances.
    instance_summary_list: ?[]const InstanceSummary,

    /// If there are additional results, this is the token for the next set of
    /// results.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .instance_summary_list = "InstanceSummaryList",
        .next_token = "NextToken",
    };
};
