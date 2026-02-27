pub const Client = @import("client.zig").Client;
pub const errors = @import("errors.zig");
pub const ServiceError = errors.ServiceError;

pub const batch_acknowledge_alarm = @import("batch_acknowledge_alarm.zig");
pub const batch_delete_detector = @import("batch_delete_detector.zig");
pub const batch_disable_alarm = @import("batch_disable_alarm.zig");
pub const batch_enable_alarm = @import("batch_enable_alarm.zig");
pub const batch_put_message = @import("batch_put_message.zig");
pub const batch_reset_alarm = @import("batch_reset_alarm.zig");
pub const batch_snooze_alarm = @import("batch_snooze_alarm.zig");
pub const batch_update_detector = @import("batch_update_detector.zig");
pub const describe_alarm = @import("describe_alarm.zig");
pub const describe_detector = @import("describe_detector.zig");
pub const list_alarms = @import("list_alarms.zig");
pub const list_detectors = @import("list_detectors.zig");
