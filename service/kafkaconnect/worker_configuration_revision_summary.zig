/// The summary of a worker configuration revision.
pub const WorkerConfigurationRevisionSummary = struct {
    /// The time that a worker configuration revision was created.
    creation_time: ?i64 = null,

    /// The description of a worker configuration revision.
    description: ?[]const u8 = null,

    /// The revision of a worker configuration.
    revision: i64 = 0,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .description = "description",
        .revision = "revision",
    };
};
