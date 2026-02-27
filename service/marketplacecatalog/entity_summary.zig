const AmiProductSummary = @import("ami_product_summary.zig").AmiProductSummary;
const ContainerProductSummary = @import("container_product_summary.zig").ContainerProductSummary;
const DataProductSummary = @import("data_product_summary.zig").DataProductSummary;
const MachineLearningProductSummary = @import("machine_learning_product_summary.zig").MachineLearningProductSummary;
const OfferSetSummary = @import("offer_set_summary.zig").OfferSetSummary;
const OfferSummary = @import("offer_summary.zig").OfferSummary;
const ResaleAuthorizationSummary = @import("resale_authorization_summary.zig").ResaleAuthorizationSummary;
const SaaSProductSummary = @import("saa_s_product_summary.zig").SaaSProductSummary;

/// This object is a container for common summary information about the entity.
/// The
/// summary doesn't contain the whole entity structure, but it does contain
/// information
/// common across all entities.
pub const EntitySummary = struct {
    /// An object that contains summary information about the AMI product.
    ami_product_summary: ?AmiProductSummary,

    /// An object that contains summary information about the container product.
    container_product_summary: ?ContainerProductSummary,

    /// An object that contains summary information about the data product.
    data_product_summary: ?DataProductSummary,

    /// The ARN associated with the unique identifier for the entity.
    entity_arn: ?[]const u8,

    /// The unique identifier for the entity.
    entity_id: ?[]const u8,

    /// The type of the entity.
    entity_type: ?[]const u8,

    /// The last time the entity was published, using ISO 8601 format
    /// (2018-02-27T13:45:22Z).
    last_modified_date: ?[]const u8,

    machine_learning_product_summary: ?MachineLearningProductSummary,

    /// The name for the entity. This value is not unique. It is defined by the
    /// seller.
    name: ?[]const u8,

    /// An object that contains summary information about the offer set.
    offer_set_summary: ?OfferSetSummary,

    /// An object that contains summary information about the offer.
    offer_summary: ?OfferSummary,

    /// An object that contains summary information about the Resale Authorization.
    resale_authorization_summary: ?ResaleAuthorizationSummary,

    /// An object that contains summary information about the SaaS product.
    saa_s_product_summary: ?SaaSProductSummary,

    /// The visibility status of the entity to buyers. This value can be `Public`
    /// (everyone can view the entity), `Limited` (the entity is visible to limited
    /// accounts only), or `Restricted` (the entity was published and then
    /// unpublished and only existing buyers can view it).
    visibility: ?[]const u8,

    pub const json_field_names = .{
        .ami_product_summary = "AmiProductSummary",
        .container_product_summary = "ContainerProductSummary",
        .data_product_summary = "DataProductSummary",
        .entity_arn = "EntityArn",
        .entity_id = "EntityId",
        .entity_type = "EntityType",
        .last_modified_date = "LastModifiedDate",
        .machine_learning_product_summary = "MachineLearningProductSummary",
        .name = "Name",
        .offer_set_summary = "OfferSetSummary",
        .offer_summary = "OfferSummary",
        .resale_authorization_summary = "ResaleAuthorizationSummary",
        .saa_s_product_summary = "SaaSProductSummary",
        .visibility = "Visibility",
    };
};
