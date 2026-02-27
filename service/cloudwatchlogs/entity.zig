const aws = @import("aws");

/// The entity associated with the log events in a `PutLogEvents` call.
pub const Entity = struct {
    /// Additional attributes of the entity that are not used to specify the
    /// identity of the
    /// entity. A list of key-value pairs.
    ///
    /// For details about how to use the attributes, see [How to add
    /// related information to
    /// telemetry](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/adding-your-own-related-telemetry.html) in the *CloudWatch User
    /// Guide*.
    attributes: ?[]const aws.map.StringMapEntry,

    /// The attributes of the entity which identify the specific entity, as a list
    /// of key-value
    /// pairs. Entities with the same `keyAttributes` are considered to be the same
    /// entity.
    ///
    /// There are five allowed attributes (key names): `Type`,
    /// `ResourceType`, `Identifier`
    /// `Name`, and `Environment`.
    ///
    /// For details about how to use the key attributes, see [How to add
    /// related information to
    /// telemetry](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/adding-your-own-related-telemetry.html) in the *CloudWatch User
    /// Guide*.
    key_attributes: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .attributes = "attributes",
        .key_attributes = "keyAttributes",
    };
};
