const AmazonConnectGuideAssociationData = @import("amazon_connect_guide_association_data.zig").AmazonConnectGuideAssociationData;

/// The contents of a content association.
pub const ContentAssociationContents = union(enum) {
    /// The data of the step-by-step guide association.
    amazon_connect_guide_association: ?AmazonConnectGuideAssociationData,

    pub const json_field_names = .{
        .amazon_connect_guide_association = "amazonConnectGuideAssociation",
    };
};
