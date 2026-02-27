const ExpirationCriterion = @import("expiration_criterion.zig").ExpirationCriterion;

/// Settings that control the interval after which a channel is deleted.
pub const ExpirationSettings = struct {
    /// The conditions that must be met for a channel to expire.
    expiration_criterion: ExpirationCriterion,

    /// The period in days after which the system automatically deletes a channel.
    expiration_days: i32,

    pub const json_field_names = .{
        .expiration_criterion = "ExpirationCriterion",
        .expiration_days = "ExpirationDays",
    };
};
