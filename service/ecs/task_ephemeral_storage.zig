/// The amount of ephemeral storage to allocate for the task.
pub const TaskEphemeralStorage = struct {
    /// Specify an Key
    /// Management Service key ID to encrypt the ephemeral storage for the
    /// task.
    kms_key_id: ?[]const u8,

    /// The total amount, in GiB, of the ephemeral storage to set for the task. The
    /// minimum
    /// supported value is `20` GiB and the maximum supported value is
    /// `200` GiB.
    size_in_gi_b: i32 = 0,

    pub const json_field_names = .{
        .kms_key_id = "kmsKeyId",
        .size_in_gi_b = "sizeInGiB",
    };
};
