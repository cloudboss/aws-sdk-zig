/// Object containing expiration events options associated with an Amazon Web
/// Services account.
pub const ExpiryEventsConfiguration = struct {
    /// Specifies the number of days prior to certificate expiration when ACM starts
    /// generating `EventBridge` events. ACM sends one event per day per certificate
    /// until the certificate expires. By default, accounts receive events starting
    /// 45 days before certificate expiration.
    days_before_expiry: ?i32 = null,

    pub const json_field_names = .{
        .days_before_expiry = "DaysBeforeExpiry",
    };
};
