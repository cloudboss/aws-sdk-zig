/// Information about an override specified for an on-call rotation.
pub const RotationOverride = struct {
    /// The time a rotation override was created.
    create_time: i64,

    /// The time a rotation override ends.
    end_time: i64,

    /// The Amazon Resource Names (ARNs) of the contacts assigned to the override of
    /// the on-call
    /// rotation.
    new_contact_ids: []const []const u8,

    /// The Amazon Resource Name (ARN) of the override to an on-call rotation.
    rotation_override_id: []const u8,

    /// The time a rotation override begins.
    start_time: i64,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .end_time = "EndTime",
        .new_contact_ids = "NewContactIds",
        .rotation_override_id = "RotationOverrideId",
        .start_time = "StartTime",
    };
};
