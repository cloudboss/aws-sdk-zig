const TestSetModality = @import("test_set_modality.zig").TestSetModality;
const TestSetStatus = @import("test_set_status.zig").TestSetStatus;
const TestSetStorageLocation = @import("test_set_storage_location.zig").TestSetStorageLocation;

/// Contains summary information about the test set.
pub const TestSetSummary = struct {
    /// The date and time at which the test set was created.
    creation_date_time: ?i64,

    /// The description of the test set.
    description: ?[]const u8,

    /// The date and time at which the test set was last updated.
    last_updated_date_time: ?i64,

    /// Specifies whether the test set contains written or spoken data.
    modality: ?TestSetModality,

    /// The number of turns in the test set.
    num_turns: ?i32,

    /// The Amazon Resource Name (ARN) of an IAM role
    /// that has permission to access the test set.
    role_arn: ?[]const u8,

    /// The status of the test set.
    status: ?TestSetStatus,

    /// Contains information about the location at which the test set is stored.
    storage_location: ?TestSetStorageLocation,

    /// The unique identifier of the test set.
    test_set_id: ?[]const u8,

    /// The name of the test set.
    test_set_name: ?[]const u8,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .description = "description",
        .last_updated_date_time = "lastUpdatedDateTime",
        .modality = "modality",
        .num_turns = "numTurns",
        .role_arn = "roleArn",
        .status = "status",
        .storage_location = "storageLocation",
        .test_set_id = "testSetId",
        .test_set_name = "testSetName",
    };
};
