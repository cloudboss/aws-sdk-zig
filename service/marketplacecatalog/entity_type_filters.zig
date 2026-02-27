const AmiProductFilters = @import("ami_product_filters.zig").AmiProductFilters;
const ContainerProductFilters = @import("container_product_filters.zig").ContainerProductFilters;
const DataProductFilters = @import("data_product_filters.zig").DataProductFilters;
const MachineLearningProductFilters = @import("machine_learning_product_filters.zig").MachineLearningProductFilters;
const OfferFilters = @import("offer_filters.zig").OfferFilters;
const OfferSetFilters = @import("offer_set_filters.zig").OfferSetFilters;
const ResaleAuthorizationFilters = @import("resale_authorization_filters.zig").ResaleAuthorizationFilters;
const SaaSProductFilters = @import("saa_s_product_filters.zig").SaaSProductFilters;

/// Object containing all the filter fields per entity type.
pub const EntityTypeFilters = union(enum) {
    /// A filter for AMI products.
    ami_product_filters: ?AmiProductFilters,
    /// A filter for container products.
    container_product_filters: ?ContainerProductFilters,
    /// A filter for data products.
    data_product_filters: ?DataProductFilters,
    machine_learning_product_filters: ?MachineLearningProductFilters,
    /// A filter for offers.
    offer_filters: ?OfferFilters,
    /// A filter for offer sets.
    offer_set_filters: ?OfferSetFilters,
    /// A filter for Resale Authorizations.
    resale_authorization_filters: ?ResaleAuthorizationFilters,
    /// A filter for SaaS products.
    saa_s_product_filters: ?SaaSProductFilters,

    pub const json_field_names = .{
        .ami_product_filters = "AmiProductFilters",
        .container_product_filters = "ContainerProductFilters",
        .data_product_filters = "DataProductFilters",
        .machine_learning_product_filters = "MachineLearningProductFilters",
        .offer_filters = "OfferFilters",
        .offer_set_filters = "OfferSetFilters",
        .resale_authorization_filters = "ResaleAuthorizationFilters",
        .saa_s_product_filters = "SaaSProductFilters",
    };
};
