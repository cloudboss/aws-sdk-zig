const aws = @import("aws");
const std = @import("std");

const batch_acknowledge_alarm = @import("batch_acknowledge_alarm.zig");
const batch_delete_detector = @import("batch_delete_detector.zig");
const batch_disable_alarm = @import("batch_disable_alarm.zig");
const batch_enable_alarm = @import("batch_enable_alarm.zig");
const batch_put_message = @import("batch_put_message.zig");
const batch_reset_alarm = @import("batch_reset_alarm.zig");
const batch_snooze_alarm = @import("batch_snooze_alarm.zig");
const batch_update_detector = @import("batch_update_detector.zig");
const describe_alarm = @import("describe_alarm.zig");
const describe_detector = @import("describe_detector.zig");
const list_alarms = @import("list_alarms.zig");
const list_detectors = @import("list_detectors.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "IoT Events Data";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Acknowledges one or more alarms. The alarms change to the `ACKNOWLEDGED`
    /// state
    /// after you acknowledge them.
    pub fn batchAcknowledgeAlarm(self: *Self, allocator: std.mem.Allocator, input: batch_acknowledge_alarm.BatchAcknowledgeAlarmInput, options: batch_acknowledge_alarm.Options) !batch_acknowledge_alarm.BatchAcknowledgeAlarmOutput {
        return batch_acknowledge_alarm.execute(self, allocator, input, options);
    }

    /// Deletes one or more detectors that were created. When a detector is deleted,
    /// its state will be cleared and the detector will be removed from the list of
    /// detectors. The deleted detector will no longer appear if referenced in the
    /// [ListDetectors](https://docs.aws.amazon.com/iotevents/latest/apireference/API_iotevents-data_ListDetectors.html) API call.
    pub fn batchDeleteDetector(self: *Self, allocator: std.mem.Allocator, input: batch_delete_detector.BatchDeleteDetectorInput, options: batch_delete_detector.Options) !batch_delete_detector.BatchDeleteDetectorOutput {
        return batch_delete_detector.execute(self, allocator, input, options);
    }

    /// Disables one or more alarms. The alarms change to the `DISABLED` state after
    /// you disable them.
    pub fn batchDisableAlarm(self: *Self, allocator: std.mem.Allocator, input: batch_disable_alarm.BatchDisableAlarmInput, options: batch_disable_alarm.Options) !batch_disable_alarm.BatchDisableAlarmOutput {
        return batch_disable_alarm.execute(self, allocator, input, options);
    }

    /// Enables one or more alarms. The alarms change to the `NORMAL` state after
    /// you
    /// enable them.
    pub fn batchEnableAlarm(self: *Self, allocator: std.mem.Allocator, input: batch_enable_alarm.BatchEnableAlarmInput, options: batch_enable_alarm.Options) !batch_enable_alarm.BatchEnableAlarmOutput {
        return batch_enable_alarm.execute(self, allocator, input, options);
    }

    /// Sends a set of messages to the IoT Events system. Each message payload is
    /// transformed into
    /// the input you specify (`"inputName"`) and ingested into any detectors that
    /// monitor
    /// that input. If multiple messages are sent, the order in which the messages
    /// are processed isn't
    /// guaranteed. To guarantee ordering, you must send messages one at a time and
    /// wait for a
    /// successful response.
    pub fn batchPutMessage(self: *Self, allocator: std.mem.Allocator, input: batch_put_message.BatchPutMessageInput, options: batch_put_message.Options) !batch_put_message.BatchPutMessageOutput {
        return batch_put_message.execute(self, allocator, input, options);
    }

    /// Resets one or more alarms. The alarms return to the `NORMAL` state after you
    /// reset them.
    pub fn batchResetAlarm(self: *Self, allocator: std.mem.Allocator, input: batch_reset_alarm.BatchResetAlarmInput, options: batch_reset_alarm.Options) !batch_reset_alarm.BatchResetAlarmOutput {
        return batch_reset_alarm.execute(self, allocator, input, options);
    }

    /// Changes one or more alarms to the snooze mode. The alarms change to the
    /// `SNOOZE_DISABLED` state after you set them to the snooze mode.
    pub fn batchSnoozeAlarm(self: *Self, allocator: std.mem.Allocator, input: batch_snooze_alarm.BatchSnoozeAlarmInput, options: batch_snooze_alarm.Options) !batch_snooze_alarm.BatchSnoozeAlarmOutput {
        return batch_snooze_alarm.execute(self, allocator, input, options);
    }

    /// Updates the state, variable values, and timer settings of one or more
    /// detectors
    /// (instances) of a specified detector model.
    pub fn batchUpdateDetector(self: *Self, allocator: std.mem.Allocator, input: batch_update_detector.BatchUpdateDetectorInput, options: batch_update_detector.Options) !batch_update_detector.BatchUpdateDetectorOutput {
        return batch_update_detector.execute(self, allocator, input, options);
    }

    /// Retrieves information about an alarm.
    pub fn describeAlarm(self: *Self, allocator: std.mem.Allocator, input: describe_alarm.DescribeAlarmInput, options: describe_alarm.Options) !describe_alarm.DescribeAlarmOutput {
        return describe_alarm.execute(self, allocator, input, options);
    }

    /// Returns information about the specified detector (instance).
    pub fn describeDetector(self: *Self, allocator: std.mem.Allocator, input: describe_detector.DescribeDetectorInput, options: describe_detector.Options) !describe_detector.DescribeDetectorOutput {
        return describe_detector.execute(self, allocator, input, options);
    }

    /// Lists one or more alarms. The operation returns only the metadata associated
    /// with each
    /// alarm.
    pub fn listAlarms(self: *Self, allocator: std.mem.Allocator, input: list_alarms.ListAlarmsInput, options: list_alarms.Options) !list_alarms.ListAlarmsOutput {
        return list_alarms.execute(self, allocator, input, options);
    }

    /// Lists detectors (the instances of a detector model).
    pub fn listDetectors(self: *Self, allocator: std.mem.Allocator, input: list_detectors.ListDetectorsInput, options: list_detectors.Options) !list_detectors.ListDetectorsOutput {
        return list_detectors.execute(self, allocator, input, options);
    }
};
