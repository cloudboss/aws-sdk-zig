const Entity = @import("entity.zig").Entity;
const Tag = @import("tag.zig").Tag;

/// An object that contains the `ChangeType`, `Details`, and
/// `Entity`.
pub const Change = struct {
    /// Optional name for the change.
    change_name: ?[]const u8,

    /// Change types are single string values that describe your intention for the
    /// change.
    /// Each change type is unique for each `EntityType` provided in the change's
    /// scope. For more information about change types available for single-AMI
    /// products, see
    /// [Working with single-AMI
    /// products](https://docs.aws.amazon.com/marketplace-catalog/latest/api-reference/ami-products.html#working-with-single-AMI-products). Also, for more information about change
    /// types available for container-based products, see [Working with container
    /// products](https://docs.aws.amazon.com/marketplace-catalog/latest/api-reference/container-products.html#working-with-container-products).
    change_type: []const u8,

    /// This object contains details specific to the change type of the requested
    /// change. For
    /// more information about change types available for single-AMI products, see
    /// [Working with single-AMI
    /// products](https://docs.aws.amazon.com/marketplace-catalog/latest/api-reference/ami-products.html#working-with-single-AMI-products). Also, for more information about change
    /// types available for container-based products, see [Working with container
    /// products](https://docs.aws.amazon.com/marketplace-catalog/latest/api-reference/container-products.html#working-with-container-products).
    details: ?[]const u8,

    /// Alternative field that accepts a JSON value instead of a string for
    /// `ChangeType` details. You can use either `Details` or
    /// `DetailsDocument`, but not both.
    ///
    /// To download the "DetailsDocument" shapes, see the
    /// [Python](https://github.com/awslabs/aws-marketplace-catalog-api-shapes-for-python)
    /// and
    /// [Java](https://github.com/awslabs/aws-marketplace-catalog-api-shapes-for-java/tree/main) shapes on GitHub.
    details_document: ?[]const u8,

    /// The entity to be changed.
    entity: Entity,

    /// The tags associated with the change.
    entity_tags: ?[]const Tag,

    pub const json_field_names = .{
        .change_name = "ChangeName",
        .change_type = "ChangeType",
        .details = "Details",
        .details_document = "DetailsDocument",
        .entity = "Entity",
        .entity_tags = "EntityTags",
    };
};
