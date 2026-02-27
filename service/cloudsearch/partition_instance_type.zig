/// The instance type (such as `search.m1.small`) on which an index partition is
/// hosted.
pub const PartitionInstanceType = enum {
    search_m_1_small,
    search_m_1_large,
    search_m_2_xlarge,
    search_m_2_2_xlarge,
    search_m_3_medium,
    search_m_3_large,
    search_m_3_xlarge,
    search_m_3_2_xlarge,
    search_small,
    search_medium,
    search_large,
    search_xlarge,
    search_2_xlarge,
    search_previousgeneration_small,
    search_previousgeneration_large,
    search_previousgeneration_xlarge,
    search_previousgeneration_2_xlarge,
};
