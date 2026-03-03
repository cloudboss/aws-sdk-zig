const AssociationStatus = @import("association_status.zig").AssociationStatus;

/// Describes an `ApiAssociation` object.
pub const ApiAssociation = struct {
    /// The API ID.
    api_id: ?[]const u8 = null,

    /// Identifies the status of an association.
    ///
    /// * **PROCESSING**: The API association is being
    /// created. You cannot modify association requests during processing.
    ///
    /// * **SUCCESS**: The API association was successful.
    /// You can modify associations after success.
    ///
    /// * **FAILED**: The API association has failed. You
    /// can modify associations after failure.
    association_status: ?AssociationStatus = null,

    /// Details about the last deployment status.
    deployment_detail: ?[]const u8 = null,

    /// The domain name.
    domain_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_id = "apiId",
        .association_status = "associationStatus",
        .deployment_detail = "deploymentDetail",
        .domain_name = "domainName",
    };
};
