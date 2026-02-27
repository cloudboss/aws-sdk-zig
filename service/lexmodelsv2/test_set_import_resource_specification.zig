const aws = @import("aws");

const TestSetImportInputLocation = @import("test_set_import_input_location.zig").TestSetImportInputLocation;
const TestSetModality = @import("test_set_modality.zig").TestSetModality;
const TestSetStorageLocation = @import("test_set_storage_location.zig").TestSetStorageLocation;

/// Contains information about the test set that is imported.
pub const TestSetImportResourceSpecification = struct {
    /// The description of the test set.
    description: ?[]const u8,

    /// Contains information about the input location from where test-set should be
    /// imported.
    import_input_location: TestSetImportInputLocation,

    /// Specifies whether the test-set being imported contains written or spoken
    /// data.
    modality: TestSetModality,

    /// The Amazon Resource Name (ARN) of an IAM role that has
    /// permission to access the test set.
    role_arn: []const u8,

    /// Contains information about the location that Amazon Lex uses to store the
    /// test-set.
    storage_location: TestSetStorageLocation,

    /// The name of the test set.
    test_set_name: []const u8,

    /// A list of tags to add to the test set. You can only add tags when you
    /// import/generate a new test set. You can't use the `UpdateTestSet` operation
    /// to update tags. To update tags, use the `TagResource` operation.
    test_set_tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .description = "description",
        .import_input_location = "importInputLocation",
        .modality = "modality",
        .role_arn = "roleArn",
        .storage_location = "storageLocation",
        .test_set_name = "testSetName",
        .test_set_tags = "testSetTags",
    };
};
