const ConditionalSplitActivity = @import("conditional_split_activity.zig").ConditionalSplitActivity;
const ContactCenterActivity = @import("contact_center_activity.zig").ContactCenterActivity;
const CustomMessageActivity = @import("custom_message_activity.zig").CustomMessageActivity;
const EmailMessageActivity = @import("email_message_activity.zig").EmailMessageActivity;
const HoldoutActivity = @import("holdout_activity.zig").HoldoutActivity;
const MultiConditionalSplitActivity = @import("multi_conditional_split_activity.zig").MultiConditionalSplitActivity;
const PushMessageActivity = @import("push_message_activity.zig").PushMessageActivity;
const RandomSplitActivity = @import("random_split_activity.zig").RandomSplitActivity;
const SMSMessageActivity = @import("sms_message_activity.zig").SMSMessageActivity;
const WaitActivity = @import("wait_activity.zig").WaitActivity;

/// Specifies the configuration and other settings for an activity in a journey.
pub const Activity = struct {
    /// The settings for a yes/no split activity. This type of activity sends
    /// participants down one of two paths in a journey, based on conditions that
    /// you specify.
    conditional_split: ?ConditionalSplitActivity,

    /// The settings for a connect activity. This type of activity initiates a
    /// contact center call to participants.
    contact_center: ?ContactCenterActivity,

    /// The settings for a custom message activity. This type of activity calls an
    /// AWS Lambda function or web hook that sends messages to participants.
    custom: ?CustomMessageActivity,

    /// The custom description of the activity.
    description: ?[]const u8,

    /// The settings for an email activity. This type of activity sends an email
    /// message to participants.
    email: ?EmailMessageActivity,

    /// The settings for a holdout activity. This type of activity stops a journey
    /// for a specified percentage of participants.
    holdout: ?HoldoutActivity,

    /// The settings for a multivariate split activity. This type of activity sends
    /// participants down one of as many as five paths (including a default *Else*
    /// path) in a journey, based on conditions that you specify.
    multi_condition: ?MultiConditionalSplitActivity,

    /// The settings for a push notification activity. This type of activity sends a
    /// push notification to participants.
    push: ?PushMessageActivity,

    /// The settings for a random split activity. This type of activity randomly
    /// sends specified percentages of participants down one of as many as five
    /// paths in a journey, based on conditions that you specify.
    random_split: ?RandomSplitActivity,

    /// The settings for an SMS activity. This type of activity sends a text message
    /// to participants.
    sms: ?SMSMessageActivity,

    /// The settings for a wait activity. This type of activity waits for a certain
    /// amount of time or until a specific date and time before moving participants
    /// to the next activity in a journey.
    wait: ?WaitActivity,

    pub const json_field_names = .{
        .conditional_split = "ConditionalSplit",
        .contact_center = "ContactCenter",
        .custom = "CUSTOM",
        .description = "Description",
        .email = "EMAIL",
        .holdout = "Holdout",
        .multi_condition = "MultiCondition",
        .push = "PUSH",
        .random_split = "RandomSplit",
        .sms = "SMS",
        .wait = "Wait",
    };
};
