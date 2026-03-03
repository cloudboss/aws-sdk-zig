const FeatureValue = @import("feature_value.zig").FeatureValue;

/// The output of records that have been retrieved in a batch.
pub const BatchGetRecordResultDetail = struct {
    /// The `ExpiresAt` ISO string of the requested record.
    expires_at: ?[]const u8 = null,

    /// The `FeatureGroupName` containing Records you retrieved in a batch.
    feature_group_name: []const u8,

    /// The `Record` retrieved.
    record: []const FeatureValue,

    /// The value of the record identifier in string format.
    record_identifier_value_as_string: []const u8,

    pub const json_field_names = .{
        .expires_at = "ExpiresAt",
        .feature_group_name = "FeatureGroupName",
        .record = "Record",
        .record_identifier_value_as_string = "RecordIdentifierValueAsString",
    };
};
