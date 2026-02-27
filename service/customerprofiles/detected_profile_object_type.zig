const aws = @import("aws");

const ObjectTypeField = @import("object_type_field.zig").ObjectTypeField;
const ObjectTypeKey = @import("object_type_key.zig").ObjectTypeKey;

/// Contains `ProfileObjectType` mapping information from the model.
pub const DetectedProfileObjectType = struct {
    /// A map of the name and the `ObjectType` field.
    fields: ?[]const aws.map.MapEntry(ObjectTypeField),

    /// A list of unique keys that can be used to map data to a profile.
    keys: ?[]const aws.map.MapEntry([]const ObjectTypeKey),

    /// The format of `sourceLastUpdatedTimestamp` that was detected in
    /// fields.
    source_last_updated_timestamp_format: ?[]const u8,

    pub const json_field_names = .{
        .fields = "Fields",
        .keys = "Keys",
        .source_last_updated_timestamp_format = "SourceLastUpdatedTimestampFormat",
    };
};
