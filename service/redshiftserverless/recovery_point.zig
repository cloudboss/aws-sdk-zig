/// The automatically created recovery point of a namespace. Recovery points are
/// created every 30 minutes and kept for 24 hours.
pub const RecoveryPoint = struct {
    /// The Amazon Resource Name (ARN) of the namespace the recovery point is
    /// associated with.
    namespace_arn: ?[]const u8,

    /// The name of the namespace the recovery point is associated with.
    namespace_name: ?[]const u8,

    /// The time the recovery point is created.
    recovery_point_create_time: ?i64,

    /// The unique identifier of the recovery point.
    recovery_point_id: ?[]const u8,

    /// The total size of the data in the recovery point in megabytes.
    total_size_in_mega_bytes: ?f64,

    /// The name of the workgroup the recovery point is associated with.
    workgroup_name: ?[]const u8,

    pub const json_field_names = .{
        .namespace_arn = "namespaceArn",
        .namespace_name = "namespaceName",
        .recovery_point_create_time = "recoveryPointCreateTime",
        .recovery_point_id = "recoveryPointId",
        .total_size_in_mega_bytes = "totalSizeInMegaBytes",
        .workgroup_name = "workgroupName",
    };
};
