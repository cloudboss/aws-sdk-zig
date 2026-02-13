/// Enum listing out all supported route types. The following enum values are
/// supported.
/// 1. Transactional : Non-marketing traffic
/// 2. Promotional : Marketing
/// 3. Premium : Premium routes for OTP delivery to the carriers
pub const RouteType = enum {
    transactional,
    promotional,
    premium,
};
