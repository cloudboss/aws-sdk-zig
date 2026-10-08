const aws = @import("aws");
const std = @import("std");

const approve_paid_subscription = @import("approve_paid_subscription.zig");
const associate_resources_to_subscription = @import("associate_resources_to_subscription.zig");
const cancel_subscription = @import("cancel_subscription.zig");
const cancel_subscription_change = @import("cancel_subscription_change.zig");
const create_subscription = @import("create_subscription.zig");
const disassociate_resources_from_subscription = @import("disassociate_resources_from_subscription.zig");
const get_subscription = @import("get_subscription.zig");
const list_subscriptions = @import("list_subscriptions.zig");
const update_subscription = @import("update_subscription.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "Pricing Plan Manager";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .options = options,
        };
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }

    /// Approves a subscription that is in `PENDING_APPROVAL` status, activating it
    /// and starting billing.
    ///
    /// This operation requires the current `ETag` value for concurrency control.
    /// Retrieve it from a previous `GetSubscription` or `ListSubscriptions`
    /// response.
    pub fn approvePaidSubscription(self: *Self, allocator: std.mem.Allocator, input: approve_paid_subscription.ApprovePaidSubscriptionInput, options: CallOptions) !approve_paid_subscription.ApprovePaidSubscriptionOutput {
        return approve_paid_subscription.execute(self, allocator, input, options);
    }

    /// Adds one or more resources to an existing subscription. The subscription
    /// must be in an active state that is not pending other changes.
    ///
    /// For subscriptions in the CloudFront plan family, the associated resources
    /// must include exactly one Amazon CloudFront distribution and one WAF web ACL.
    /// You can also include other supported resources, such as Amazon Route 53
    /// hosted zones, and CloudFront KeyValueStores.
    pub fn associateResourcesToSubscription(self: *Self, allocator: std.mem.Allocator, input: associate_resources_to_subscription.AssociateResourcesToSubscriptionInput, options: CallOptions) !associate_resources_to_subscription.AssociateResourcesToSubscriptionOutput {
        return associate_resources_to_subscription.execute(self, allocator, input, options);
    }

    /// Cancels a flat-rate pricing subscription.
    ///
    /// For active subscriptions, the cancellation is scheduled to take effect at
    /// the end of the current billing period. The subscription remains active until
    /// that date. To revert a pending cancellation, use `CancelSubscriptionChange`.
    ///
    /// For subscriptions in `PENDING_APPROVAL` status, the subscription is deleted
    /// immediately without scheduling.
    pub fn cancelSubscription(self: *Self, allocator: std.mem.Allocator, input: cancel_subscription.CancelSubscriptionInput, options: CallOptions) !cancel_subscription.CancelSubscriptionOutput {
        return cancel_subscription.execute(self, allocator, input, options);
    }

    /// Cancels a pending scheduled change on a subscription, such as a pending
    /// downgrade or cancellation. The subscription returns to its state before the
    /// change was scheduled.
    ///
    /// You cannot cancel a scheduled change close to its effective date. If the
    /// change is within the processing window, this operation returns an error.
    pub fn cancelSubscriptionChange(self: *Self, allocator: std.mem.Allocator, input: cancel_subscription_change.CancelSubscriptionChangeInput, options: CallOptions) !cancel_subscription_change.CancelSubscriptionChangeOutput {
        return cancel_subscription_change.execute(self, allocator, input, options);
    }

    /// Creates a flat-rate pricing subscription for the specified resources.
    ///
    /// When `approvalMode` is set to `MANUAL`, paid-tier subscriptions are created
    /// in `PENDING_APPROVAL` status and require a separate
    /// `ApprovePaidSubscription` call before billing starts. Free-tier
    /// subscriptions are always activated immediately regardless of approval mode.
    ///
    /// When `approvalMode` is set to `IMMEDIATE` or is not specified, the
    /// subscription is activated immediately.
    pub fn createSubscription(self: *Self, allocator: std.mem.Allocator, input: create_subscription.CreateSubscriptionInput, options: CallOptions) !create_subscription.CreateSubscriptionOutput {
        return create_subscription.execute(self, allocator, input, options);
    }

    /// Removes one or more resources from an existing subscription.
    ///
    /// For subscriptions in the CloudFront plan family, the associated resources
    /// must always include exactly one Amazon CloudFront distribution and exactly
    /// one WAF web ACL. You cannot remove these required resources.
    pub fn disassociateResourcesFromSubscription(self: *Self, allocator: std.mem.Allocator, input: disassociate_resources_from_subscription.DisassociateResourcesFromSubscriptionInput, options: CallOptions) !disassociate_resources_from_subscription.DisassociateResourcesFromSubscriptionOutput {
        return disassociate_resources_from_subscription.execute(self, allocator, input, options);
    }

    /// Returns the details of a flat-rate pricing subscription, including its
    /// current status, associated resources, and any pending scheduled changes.
    pub fn getSubscription(self: *Self, allocator: std.mem.Allocator, input: get_subscription.GetSubscriptionInput, options: CallOptions) !get_subscription.GetSubscriptionOutput {
        return get_subscription.execute(self, allocator, input, options);
    }

    /// Returns a summary of all flat-rate pricing subscriptions in the calling
    /// account.
    pub fn listSubscriptions(self: *Self, allocator: std.mem.Allocator, input: list_subscriptions.ListSubscriptionsInput, options: CallOptions) !list_subscriptions.ListSubscriptionsOutput {
        return list_subscriptions.execute(self, allocator, input, options);
    }

    /// Changes the plan tier of an existing subscription.
    ///
    /// Upgrades take effect immediately. Downgrades are scheduled and the current
    /// tier remains unchanged until the end of the billing cycle (calendar month).
    /// You cannot update a subscription while a scheduled change is pending. To
    /// make a new change, first cancel the pending change using
    /// `CancelSubscriptionChange`.
    ///
    /// This operation replaces the plan tier value. If you omit the optional
    /// `usageLevel` field, it is reset to the default.
    pub fn updateSubscription(self: *Self, allocator: std.mem.Allocator, input: update_subscription.UpdateSubscriptionInput, options: CallOptions) !update_subscription.UpdateSubscriptionOutput {
        return update_subscription.execute(self, allocator, input, options);
    }

    pub fn listSubscriptionsPaginator(self: *Self, params: list_subscriptions.ListSubscriptionsInput) paginator.ListSubscriptionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
