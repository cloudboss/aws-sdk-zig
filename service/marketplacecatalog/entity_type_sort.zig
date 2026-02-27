const AmiProductSort = @import("ami_product_sort.zig").AmiProductSort;
const ContainerProductSort = @import("container_product_sort.zig").ContainerProductSort;
const DataProductSort = @import("data_product_sort.zig").DataProductSort;
const MachineLearningProductSort = @import("machine_learning_product_sort.zig").MachineLearningProductSort;
const OfferSetSort = @import("offer_set_sort.zig").OfferSetSort;
const OfferSort = @import("offer_sort.zig").OfferSort;
const ResaleAuthorizationSort = @import("resale_authorization_sort.zig").ResaleAuthorizationSort;
const SaaSProductSort = @import("saa_s_product_sort.zig").SaaSProductSort;

/// Object containing all the sort fields per entity type.
pub const EntityTypeSort = union(enum) {
    /// A sort for AMI products.
    ami_product_sort: ?AmiProductSort,
    /// A sort for container products.
    container_product_sort: ?ContainerProductSort,
    /// A sort for data products.
    data_product_sort: ?DataProductSort,
    machine_learning_product_sort: ?MachineLearningProductSort,
    /// A sort for offer sets.
    offer_set_sort: ?OfferSetSort,
    /// A sort for offers.
    offer_sort: ?OfferSort,
    /// A sort for Resale Authorizations.
    resale_authorization_sort: ?ResaleAuthorizationSort,
    /// A sort for SaaS products.
    saa_s_product_sort: ?SaaSProductSort,

    pub const json_field_names = .{
        .ami_product_sort = "AmiProductSort",
        .container_product_sort = "ContainerProductSort",
        .data_product_sort = "DataProductSort",
        .machine_learning_product_sort = "MachineLearningProductSort",
        .offer_set_sort = "OfferSetSort",
        .offer_sort = "OfferSort",
        .resale_authorization_sort = "ResaleAuthorizationSort",
        .saa_s_product_sort = "SaaSProductSort",
    };
};
