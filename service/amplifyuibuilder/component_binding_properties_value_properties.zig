const Predicate = @import("predicate.zig").Predicate;

/// Represents the data binding configuration for a specific property using data
/// stored in
/// Amazon Web Services. For Amazon Web Services connected properties, you can
/// bind a property to
/// data stored in an Amazon S3 bucket, an Amplify DataStore model or an
/// authenticated user attribute.
pub const ComponentBindingPropertiesValueProperties = struct {
    /// An Amazon S3 bucket.
    bucket: ?[]const u8,

    /// The default value to assign to the property.
    default_value: ?[]const u8,

    /// The field to bind the data to.
    field: ?[]const u8,

    /// The storage key for an Amazon S3 bucket.
    key: ?[]const u8,

    /// An Amplify DataStore model.
    model: ?[]const u8,

    /// A list of predicates for binding a component's properties to data.
    predicates: ?[]const Predicate,

    /// The name of a component slot.
    slot_name: ?[]const u8,

    /// An authenticated user attribute.
    user_attribute: ?[]const u8,

    pub const json_field_names = .{
        .bucket = "bucket",
        .default_value = "defaultValue",
        .field = "field",
        .key = "key",
        .model = "model",
        .predicates = "predicates",
        .slot_name = "slotName",
        .user_attribute = "userAttribute",
    };
};
