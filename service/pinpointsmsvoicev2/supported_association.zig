const RegistrationAssociationBehavior = @import("registration_association_behavior.zig").RegistrationAssociationBehavior;
const RegistrationDisassociationBehavior = @import("registration_disassociation_behavior.zig").RegistrationDisassociationBehavior;

/// The processing rules for when a registration can be associated with an
/// origination identity and disassociated from an origination identity.
pub const SupportedAssociation = struct {
    /// The association behavior.
    ///
    /// * `ASSOCIATE_BEFORE_SUBMIT` The origination identity has to be supplied when
    ///   creating a registration.
    /// * `ASSOCIATE_ON_APPROVAL` This applies to all sender ID registrations. The
    ///   sender ID will be automatically provisioned once the registration is
    ///   approved.
    /// * `ASSOCIATE_AFTER_COMPLETE` This applies to phone number registrations when
    ///   you must complete a registration first, then associate one or more phone
    ///   numbers later. For example 10DLC campaigns and long codes.
    association_behavior: RegistrationAssociationBehavior,

    /// The disassociation behavior.
    ///
    /// * `DISASSOCIATE_ALL_CLOSES_REGISTRATION` All origination identities must be
    ///   disassociated from the registration before the registration can be closed.
    /// * `DISASSOCIATE_ALL_ALLOWS_DELETE_REGISTRATION` All origination identities
    ///   must be disassociated from the registration before the registration can be
    ///   deleted.
    /// * `DELETE_REGISTRATION_DISASSOCIATES` The registration can be deleted and
    ///   all origination identities will be disasscoiated.
    disassociation_behavior: RegistrationDisassociationBehavior,

    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region.
    iso_country_code: ?[]const u8,

    /// Defines the behavior of when an origination identity and registration can be
    /// associated with each other.
    resource_type: []const u8,

    pub const json_field_names = .{
        .association_behavior = "AssociationBehavior",
        .disassociation_behavior = "DisassociationBehavior",
        .iso_country_code = "IsoCountryCode",
        .resource_type = "ResourceType",
    };
};
