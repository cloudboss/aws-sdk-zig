/// Provide transition lifecycle details of Amazon Security Lake object.
pub const DataLakeLifecycleTransition = struct {
    /// Number of days before data transitions to a different S3 Storage Class in
    /// the Amazon Security Lake object.
    days: ?i32,

    /// The range of storage classes that you can choose from based on the data
    /// access,
    /// resiliency, and cost requirements of your workloads.
    storage_class: ?[]const u8,

    pub const json_field_names = .{
        .days = "days",
        .storage_class = "storageClass",
    };
};
