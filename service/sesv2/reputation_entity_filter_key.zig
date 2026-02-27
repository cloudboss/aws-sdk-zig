/// The filter key to use when listing reputation entities. This can be one of
/// the following:
///
/// * `ENTITY_TYPE` – Filter by entity type.
///
/// * `REPUTATION_IMPACT` – Filter by reputation impact level.
///
/// * `SENDING_STATUS` – Filter by aggregate sending status.
///
/// * `ENTITY_REFERENCE_PREFIX` – Filter by entity reference prefix.
pub const ReputationEntityFilterKey = enum {
    entity_type,
    reputation_impact,
    status,
    entity_reference_prefix,

    pub const json_field_names = .{
        .entity_type = "ENTITY_TYPE",
        .reputation_impact = "REPUTATION_IMPACT",
        .status = "STATUS",
        .entity_reference_prefix = "ENTITY_REFERENCE_PREFIX",
    };
};
