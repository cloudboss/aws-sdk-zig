const DatasetOrgAttributes = @import("dataset_org_attributes.zig").DatasetOrgAttributes;
const RecordLength = @import("record_length.zig").RecordLength;

/// Defines a data set.
pub const DataSet = struct {
    /// The logical identifier for a specific data set (in mainframe format).
    dataset_name: []const u8,

    /// The type of dataset. The only supported value is VSAM.
    dataset_org: DatasetOrgAttributes,

    /// The length of a record.
    record_length: RecordLength,

    /// The relative location of the data set in the database or file system.
    relative_path: ?[]const u8,

    /// The storage type of the data set: database or file system. For Micro Focus,
    /// database
    /// corresponds to datastore and file system corresponds to EFS/FSX. For Blu
    /// Age, there is no
    /// support of file system and database corresponds to Blusam.
    storage_type: ?[]const u8,

    pub const json_field_names = .{
        .dataset_name = "datasetName",
        .dataset_org = "datasetOrg",
        .record_length = "recordLength",
        .relative_path = "relativePath",
        .storage_type = "storageType",
    };
};
