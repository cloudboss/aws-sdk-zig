/// Information about the workload.
pub const AwsEksWorkloadInfo = struct {
    /// The name of the workload.
    name: []const u8,

    /// The workload type.
    type: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .type = "type",
    };
};
