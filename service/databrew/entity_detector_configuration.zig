const AllowedStatistics = @import("allowed_statistics.zig").AllowedStatistics;

/// Configuration of entity detection for a profile job. When undefined, entity
/// detection is disabled.
pub const EntityDetectorConfiguration = struct {
    /// Configuration of statistics that are allowed to be run on columns that
    /// contain detected entities. When undefined, no statistics will be computed
    /// on columns that contain detected entities.
    allowed_statistics: ?[]const AllowedStatistics = null,

    /// Entity types to detect. Can be any of the following:
    ///
    /// * USA_SSN
    ///
    /// * EMAIL
    ///
    /// * USA_ITIN
    ///
    /// * USA_PASSPORT_NUMBER
    ///
    /// * PHONE_NUMBER
    ///
    /// * USA_DRIVING_LICENSE
    ///
    /// * BANK_ACCOUNT
    ///
    /// * CREDIT_CARD
    ///
    /// * IP_ADDRESS
    ///
    /// * MAC_ADDRESS
    ///
    /// * USA_DEA_NUMBER
    ///
    /// * USA_HCPCS_CODE
    ///
    /// * USA_NATIONAL_PROVIDER_IDENTIFIER
    ///
    /// * USA_NATIONAL_DRUG_CODE
    ///
    /// * USA_HEALTH_INSURANCE_CLAIM_NUMBER
    ///
    /// * USA_MEDICARE_BENEFICIARY_IDENTIFIER
    ///
    /// * USA_CPT_CODE
    ///
    /// * PERSON_NAME
    ///
    /// * DATE
    ///
    /// The Entity type group USA_ALL is also supported, and includes all of the
    /// above entity types except PERSON_NAME and DATE.
    entity_types: []const []const u8,

    pub const json_field_names = .{
        .allowed_statistics = "AllowedStatistics",
        .entity_types = "EntityTypes",
    };
};
