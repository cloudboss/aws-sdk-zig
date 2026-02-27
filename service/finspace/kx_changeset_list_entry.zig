const ChangesetStatus = @import("changeset_status.zig").ChangesetStatus;

/// Details of changeset.
pub const KxChangesetListEntry = struct {
    /// Beginning time from which the changeset is active. The value is determined
    /// as epoch time in
    /// milliseconds. For example, the value for Monday, November 1, 2021 12:00:00
    /// PM UTC is specified as
    /// 1635768000000.
    active_from_timestamp: ?i64,

    /// A unique identifier for the changeset.
    changeset_id: ?[]const u8,

    /// The timestamp at which the changeset was created in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    created_timestamp: ?i64,

    /// The timestamp at which the changeset was modified. The value is determined
    /// as epoch time in milliseconds. For example, the value for Monday, November
    /// 1, 2021 12:00:00 PM UTC is specified as
    /// 1635768000000.
    last_modified_timestamp: ?i64,

    /// Status of the changeset.
    ///
    /// * Pending – Changeset creation is pending.
    ///
    /// * Processing – Changeset creation is running.
    ///
    /// * Failed – Changeset creation has failed.
    ///
    /// * Complete – Changeset creation has succeeded.
    status: ?ChangesetStatus,

    pub const json_field_names = .{
        .active_from_timestamp = "activeFromTimestamp",
        .changeset_id = "changesetId",
        .created_timestamp = "createdTimestamp",
        .last_modified_timestamp = "lastModifiedTimestamp",
        .status = "status",
    };
};
