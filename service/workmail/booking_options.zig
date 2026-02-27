/// At least one delegate must be associated to the resource to disable
/// automatic replies
/// from the resource.
pub const BookingOptions = struct {
    /// The resource's ability to automatically reply to requests. If disabled,
    /// delegates
    /// must be associated to the resource.
    auto_accept_requests: bool = false,

    /// The resource's ability to automatically decline any conflicting requests.
    auto_decline_conflicting_requests: bool = false,

    /// The resource's ability to automatically decline any recurring requests.
    auto_decline_recurring_requests: bool = false,

    pub const json_field_names = .{
        .auto_accept_requests = "AutoAcceptRequests",
        .auto_decline_conflicting_requests = "AutoDeclineConflictingRequests",
        .auto_decline_recurring_requests = "AutoDeclineRecurringRequests",
    };
};
