const ExpirationCriterion = @import("expiration_criterion.zig").ExpirationCriterion;

/// Determines the interval after which an `AppInstanceUser` is automatically
/// deleted.
pub const ExpirationSettings = struct {
    /// Specifies the conditions under which an `AppInstanceUser` will expire.
    expiration_criterion: ExpirationCriterion,

    /// The period in days after which an `AppInstanceUser` will be automatically
    /// deleted.
    expiration_days: i32,

    pub const json_field_names = .{
        .expiration_criterion = "ExpirationCriterion",
        .expiration_days = "ExpirationDays",
    };
};
