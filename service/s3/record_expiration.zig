const ExpirationState = @import("expiration_state.zig").ExpirationState;

/// The journal table record expiration settings for a journal table in an S3
/// Metadata configuration.
pub const RecordExpiration = struct {
    /// If you enable journal table record expiration, you can set the number of
    /// days to retain your
    /// journal table records. Journal table records must be retained for a minimum
    /// of 7 days. To set
    /// this value, specify any whole number from `7` to `2147483647`. For example,
    /// to retain your journal table records for one year, set this value to `365`.
    days: ?i32 = null,

    /// Specifies whether journal table record expiration is enabled or disabled.
    expiration: ExpirationState,
};
