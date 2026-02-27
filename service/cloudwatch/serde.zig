const aws = @import("aws");
const std = @import("std");

const ActionsSuppressedBy = @import("actions_suppressed_by.zig").ActionsSuppressedBy;
const AlarmContributor = @import("alarm_contributor.zig").AlarmContributor;
const AlarmHistoryItem = @import("alarm_history_item.zig").AlarmHistoryItem;
const AlarmType = @import("alarm_type.zig").AlarmType;
const AnomalyDetector = @import("anomaly_detector.zig").AnomalyDetector;
const AnomalyDetectorConfiguration = @import("anomaly_detector_configuration.zig").AnomalyDetectorConfiguration;
const AnomalyDetectorStateValue = @import("anomaly_detector_state_value.zig").AnomalyDetectorStateValue;
const AnomalyDetectorType = @import("anomaly_detector_type.zig").AnomalyDetectorType;
const ComparisonOperator = @import("comparison_operator.zig").ComparisonOperator;
const CompositeAlarm = @import("composite_alarm.zig").CompositeAlarm;
const DashboardEntry = @import("dashboard_entry.zig").DashboardEntry;
const DashboardValidationMessage = @import("dashboard_validation_message.zig").DashboardValidationMessage;
const Datapoint = @import("datapoint.zig").Datapoint;
const Dimension = @import("dimension.zig").Dimension;
const DimensionFilter = @import("dimension_filter.zig").DimensionFilter;
const Entity = @import("entity.zig").Entity;
const EntityMetricData = @import("entity_metric_data.zig").EntityMetricData;
const EvaluationState = @import("evaluation_state.zig").EvaluationState;
const HistoryItemType = @import("history_item_type.zig").HistoryItemType;
const InsightRule = @import("insight_rule.zig").InsightRule;
const InsightRuleContributor = @import("insight_rule_contributor.zig").InsightRuleContributor;
const InsightRuleContributorDatapoint = @import("insight_rule_contributor_datapoint.zig").InsightRuleContributorDatapoint;
const InsightRuleMetricDatapoint = @import("insight_rule_metric_datapoint.zig").InsightRuleMetricDatapoint;
const LabelOptions = @import("label_options.zig").LabelOptions;
const ManagedRule = @import("managed_rule.zig").ManagedRule;
const ManagedRuleDescription = @import("managed_rule_description.zig").ManagedRuleDescription;
const ManagedRuleState = @import("managed_rule_state.zig").ManagedRuleState;
const MessageData = @import("message_data.zig").MessageData;
const Metric = @import("metric.zig").Metric;
const MetricAlarm = @import("metric_alarm.zig").MetricAlarm;
const MetricCharacteristics = @import("metric_characteristics.zig").MetricCharacteristics;
const MetricDataQuery = @import("metric_data_query.zig").MetricDataQuery;
const MetricDataResult = @import("metric_data_result.zig").MetricDataResult;
const MetricDatum = @import("metric_datum.zig").MetricDatum;
const MetricMathAnomalyDetector = @import("metric_math_anomaly_detector.zig").MetricMathAnomalyDetector;
const MetricStat = @import("metric_stat.zig").MetricStat;
const MetricStreamEntry = @import("metric_stream_entry.zig").MetricStreamEntry;
const MetricStreamFilter = @import("metric_stream_filter.zig").MetricStreamFilter;
const MetricStreamOutputFormat = @import("metric_stream_output_format.zig").MetricStreamOutputFormat;
const MetricStreamStatisticsConfiguration = @import("metric_stream_statistics_configuration.zig").MetricStreamStatisticsConfiguration;
const MetricStreamStatisticsMetric = @import("metric_stream_statistics_metric.zig").MetricStreamStatisticsMetric;
const PartialFailure = @import("partial_failure.zig").PartialFailure;
const Range = @import("range.zig").Range;
const SingleMetricAnomalyDetector = @import("single_metric_anomaly_detector.zig").SingleMetricAnomalyDetector;
const StandardUnit = @import("standard_unit.zig").StandardUnit;
const StateValue = @import("state_value.zig").StateValue;
const Statistic = @import("statistic.zig").Statistic;
const StatisticSet = @import("statistic_set.zig").StatisticSet;
const StatusCode = @import("status_code.zig").StatusCode;
const Tag = @import("tag.zig").Tag;

pub fn deserializeAlarmContributors(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AlarmContributor {
    var list: std.ArrayList(AlarmContributor) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAlarmContributor(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAlarmHistoryItems(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AlarmHistoryItem {
    var list: std.ArrayList(AlarmHistoryItem) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAlarmHistoryItem(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAnomalyDetectorExcludedTimeRanges(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Range {
    var list: std.ArrayList(Range) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeRange(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAnomalyDetectors(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AnomalyDetector {
    var list: std.ArrayList(AnomalyDetector) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAnomalyDetector(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeBatchFailures(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PartialFailure {
    var list: std.ArrayList(PartialFailure) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePartialFailure(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeCompositeAlarms(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const CompositeAlarm {
    var list: std.ArrayList(CompositeAlarm) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeCompositeAlarm(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDashboardEntries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DashboardEntry {
    var list: std.ArrayList(DashboardEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDashboardEntry(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDashboardValidationMessages(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DashboardValidationMessage {
    var list: std.ArrayList(DashboardValidationMessage) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDashboardValidationMessage(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDatapointValues(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const f64 {
    var list: std.ArrayList(f64) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.fmt.parseFloat(f64, try reader.readElementText()) catch null) |v| try list.append(alloc, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDatapoints(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Datapoint {
    var list: std.ArrayList(Datapoint) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDatapoint(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDimensions(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Dimension {
    var list: std.ArrayList(Dimension) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDimension(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeInsightRuleContributorDatapoints(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const InsightRuleContributorDatapoint {
    var list: std.ArrayList(InsightRuleContributorDatapoint) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeInsightRuleContributorDatapoint(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeInsightRuleContributorKeyLabels(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeInsightRuleContributorKeys(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeInsightRuleContributors(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const InsightRuleContributor {
    var list: std.ArrayList(InsightRuleContributor) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeInsightRuleContributor(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeInsightRuleMetricDatapoints(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const InsightRuleMetricDatapoint {
    var list: std.ArrayList(InsightRuleMetricDatapoint) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeInsightRuleMetricDatapoint(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeInsightRules(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const InsightRule {
    var list: std.ArrayList(InsightRule) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeInsightRule(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeManagedRuleDescriptions(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ManagedRuleDescription {
    var list: std.ArrayList(ManagedRuleDescription) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeManagedRuleDescription(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeMetricAlarms(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const MetricAlarm {
    var list: std.ArrayList(MetricAlarm) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeMetricAlarm(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeMetricDataQueries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const MetricDataQuery {
    var list: std.ArrayList(MetricDataQuery) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeMetricDataQuery(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeMetricDataResultMessages(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const MessageData {
    var list: std.ArrayList(MessageData) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeMessageData(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeMetricDataResults(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const MetricDataResult {
    var list: std.ArrayList(MetricDataResult) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeMetricDataResult(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeMetricStreamEntries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const MetricStreamEntry {
    var list: std.ArrayList(MetricStreamEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeMetricStreamEntry(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeMetricStreamFilterMetricNames(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeMetricStreamFilters(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const MetricStreamFilter {
    var list: std.ArrayList(MetricStreamFilter) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeMetricStreamFilter(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeMetricStreamStatisticsAdditionalStatistics(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeMetricStreamStatisticsConfigurations(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const MetricStreamStatisticsConfiguration {
    var list: std.ArrayList(MetricStreamStatisticsConfiguration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeMetricStreamStatisticsConfiguration(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeMetricStreamStatisticsIncludeMetrics(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const MetricStreamStatisticsMetric {
    var list: std.ArrayList(MetricStreamStatisticsMetric) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeMetricStreamStatisticsMetric(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeMetrics(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Metric {
    var list: std.ArrayList(Metric) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeMetric(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeOwningAccounts(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeResourceList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeTagList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Tag {
    var list: std.ArrayList(Tag) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTag(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeTimestamps(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const i64 {
    var list: std.ArrayList(i64) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (aws.date.parseIso8601(try reader.readElementText()) catch null) |v| try list.append(alloc, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeContributorAttributes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
    var list: std.ArrayList(aws.map.StringMapEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, entry_tag)) {
                    var entry_key: []const u8 = "";
                    var entry_value: []const u8 = undefined;
                    while (try reader.next()) |inner| {
                        switch (inner) {
                            .element_start => |ie| {
                                if (std.mem.eql(u8, ie.local, "key")) {
                                    entry_key = try alloc.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try alloc.dupe(u8, try reader.readElementText());
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(alloc, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeDatapointValueMap(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime entry_tag: []const u8) ![]const aws.map.MapEntry(f64) {
    var list: std.ArrayList(aws.map.MapEntry(f64)) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, entry_tag)) {
                    var entry_key: []const u8 = "";
                    var entry_value: f64 = undefined;
                    while (try reader.next()) |inner| {
                        switch (inner) {
                            .element_start => |ie| {
                                if (std.mem.eql(u8, ie.local, "key")) {
                                    entry_key = try alloc.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = std.fmt.parseFloat(f64, try reader.readElementText()) catch 0;
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(alloc, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAlarmContributor(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AlarmContributor {
    var result: AlarmContributor = undefined;
    result.state_transitioned_timestamp = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ContributorAttributes")) {
                    result.contributor_attributes = try deserializeContributorAttributes(reader, alloc, "entry");
                } else if (std.mem.eql(u8, e.local, "ContributorId")) {
                    result.contributor_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StateReason")) {
                    result.state_reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StateTransitionedTimestamp")) {
                    result.state_transitioned_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAlarmHistoryItem(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AlarmHistoryItem {
    var result: AlarmHistoryItem = undefined;
    result.alarm_contributor_attributes = null;
    result.alarm_contributor_id = null;
    result.alarm_name = null;
    result.alarm_type = null;
    result.history_data = null;
    result.history_item_type = null;
    result.history_summary = null;
    result.timestamp = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AlarmContributorAttributes")) {
                    result.alarm_contributor_attributes = try deserializeContributorAttributes(reader, alloc, "entry");
                } else if (std.mem.eql(u8, e.local, "AlarmContributorId")) {
                    result.alarm_contributor_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AlarmName")) {
                    result.alarm_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AlarmType")) {
                    result.alarm_type = std.meta.stringToEnum(AlarmType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HistoryData")) {
                    result.history_data = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HistoryItemType")) {
                    result.history_item_type = std.meta.stringToEnum(HistoryItemType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HistorySummary")) {
                    result.history_summary = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Timestamp")) {
                    result.timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAnomalyDetector(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AnomalyDetector {
    var result: AnomalyDetector = undefined;
    result.configuration = null;
    result.dimensions = null;
    result.metric_characteristics = null;
    result.metric_math_anomaly_detector = null;
    result.metric_name = null;
    result.namespace = null;
    result.single_metric_anomaly_detector = null;
    result.stat = null;
    result.state_value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Configuration")) {
                    result.configuration = try deserializeAnomalyDetectorConfiguration(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Dimensions")) {
                    result.dimensions = try deserializeDimensions(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "MetricCharacteristics")) {
                    result.metric_characteristics = try deserializeMetricCharacteristics(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "MetricMathAnomalyDetector")) {
                    result.metric_math_anomaly_detector = try deserializeMetricMathAnomalyDetector(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "MetricName")) {
                    result.metric_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SingleMetricAnomalyDetector")) {
                    result.single_metric_anomaly_detector = try deserializeSingleMetricAnomalyDetector(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Stat")) {
                    result.stat = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StateValue")) {
                    result.state_value = std.meta.stringToEnum(AnomalyDetectorStateValue, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAnomalyDetectorConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AnomalyDetectorConfiguration {
    var result: AnomalyDetectorConfiguration = undefined;
    result.excluded_time_ranges = null;
    result.metric_timezone = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ExcludedTimeRanges")) {
                    result.excluded_time_ranges = try deserializeAnomalyDetectorExcludedTimeRanges(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "MetricTimezone")) {
                    result.metric_timezone = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeCompositeAlarm(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !CompositeAlarm {
    var result: CompositeAlarm = undefined;
    result.actions_enabled = null;
    result.actions_suppressed_by = null;
    result.actions_suppressed_reason = null;
    result.actions_suppressor = null;
    result.actions_suppressor_extension_period = null;
    result.actions_suppressor_wait_period = null;
    result.alarm_actions = null;
    result.alarm_arn = null;
    result.alarm_configuration_updated_timestamp = null;
    result.alarm_description = null;
    result.alarm_name = null;
    result.alarm_rule = null;
    result.insufficient_data_actions = null;
    result.ok_actions = null;
    result.state_reason = null;
    result.state_reason_data = null;
    result.state_transitioned_timestamp = null;
    result.state_updated_timestamp = null;
    result.state_value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActionsEnabled")) {
                    result.actions_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ActionsSuppressedBy")) {
                    result.actions_suppressed_by = std.meta.stringToEnum(ActionsSuppressedBy, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActionsSuppressedReason")) {
                    result.actions_suppressed_reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActionsSuppressor")) {
                    result.actions_suppressor = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ActionsSuppressorExtensionPeriod")) {
                    result.actions_suppressor_extension_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ActionsSuppressorWaitPeriod")) {
                    result.actions_suppressor_wait_period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "AlarmActions")) {
                    result.alarm_actions = try deserializeResourceList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "AlarmArn")) {
                    result.alarm_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AlarmConfigurationUpdatedTimestamp")) {
                    result.alarm_configuration_updated_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "AlarmDescription")) {
                    result.alarm_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AlarmName")) {
                    result.alarm_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AlarmRule")) {
                    result.alarm_rule = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InsufficientDataActions")) {
                    result.insufficient_data_actions = try deserializeResourceList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "OKActions")) {
                    result.ok_actions = try deserializeResourceList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "StateReason")) {
                    result.state_reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StateReasonData")) {
                    result.state_reason_data = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StateTransitionedTimestamp")) {
                    result.state_transitioned_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "StateUpdatedTimestamp")) {
                    result.state_updated_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "StateValue")) {
                    result.state_value = std.meta.stringToEnum(StateValue, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDashboardEntry(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DashboardEntry {
    var result: DashboardEntry = undefined;
    result.dashboard_arn = null;
    result.dashboard_name = null;
    result.last_modified = null;
    result.size = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DashboardArn")) {
                    result.dashboard_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DashboardName")) {
                    result.dashboard_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastModified")) {
                    result.last_modified = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Size")) {
                    result.size = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDashboardValidationMessage(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DashboardValidationMessage {
    var result: DashboardValidationMessage = undefined;
    result.data_path = null;
    result.message = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DataPath")) {
                    result.data_path = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDatapoint(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Datapoint {
    var result: Datapoint = undefined;
    result.average = null;
    result.extended_statistics = null;
    result.maximum = null;
    result.minimum = null;
    result.sample_count = null;
    result.sum = null;
    result.timestamp = null;
    result.unit = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Average")) {
                    result.average = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ExtendedStatistics")) {
                    result.extended_statistics = try deserializeDatapointValueMap(reader, alloc, "entry");
                } else if (std.mem.eql(u8, e.local, "Maximum")) {
                    result.maximum = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Minimum")) {
                    result.minimum = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SampleCount")) {
                    result.sample_count = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Sum")) {
                    result.sum = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Timestamp")) {
                    result.timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Unit")) {
                    result.unit = std.meta.stringToEnum(StandardUnit, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDimension(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Dimension {
    var result: Dimension = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInsightRule(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InsightRule {
    var result: InsightRule = undefined;
    result.apply_on_transformed_logs = null;
    result.managed_rule = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApplyOnTransformedLogs")) {
                    result.apply_on_transformed_logs = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Definition")) {
                    result.definition = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ManagedRule")) {
                    result.managed_rule = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Schema")) {
                    result.schema = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInsightRuleContributor(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InsightRuleContributor {
    var result: InsightRuleContributor = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApproximateAggregateValue")) {
                    result.approximate_aggregate_value = try std.fmt.parseFloat(f64, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Datapoints")) {
                    result.datapoints = try deserializeInsightRuleContributorDatapoints(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Keys")) {
                    result.keys = try deserializeInsightRuleContributorKeys(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInsightRuleContributorDatapoint(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InsightRuleContributorDatapoint {
    _ = alloc;
    var result: InsightRuleContributorDatapoint = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApproximateValue")) {
                    result.approximate_value = try std.fmt.parseFloat(f64, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Timestamp")) {
                    result.timestamp = try aws.date.parseIso8601(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInsightRuleMetricDatapoint(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InsightRuleMetricDatapoint {
    _ = alloc;
    var result: InsightRuleMetricDatapoint = undefined;
    result.average = null;
    result.max_contributor_value = null;
    result.maximum = null;
    result.minimum = null;
    result.sample_count = null;
    result.sum = null;
    result.unique_contributors = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Average")) {
                    result.average = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxContributorValue")) {
                    result.max_contributor_value = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Maximum")) {
                    result.maximum = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Minimum")) {
                    result.minimum = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SampleCount")) {
                    result.sample_count = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Sum")) {
                    result.sum = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Timestamp")) {
                    result.timestamp = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UniqueContributors")) {
                    result.unique_contributors = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeManagedRuleDescription(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ManagedRuleDescription {
    var result: ManagedRuleDescription = undefined;
    result.resource_arn = null;
    result.rule_state = null;
    result.template_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ResourceARN")) {
                    result.resource_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RuleState")) {
                    result.rule_state = try deserializeManagedRuleState(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "TemplateName")) {
                    result.template_name = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeManagedRuleState(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ManagedRuleState {
    var result: ManagedRuleState = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RuleName")) {
                    result.rule_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMessageData(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MessageData {
    var result: MessageData = undefined;
    result.code = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Code")) {
                    result.code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetric(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Metric {
    var result: Metric = undefined;
    result.dimensions = null;
    result.metric_name = null;
    result.namespace = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Dimensions")) {
                    result.dimensions = try deserializeDimensions(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "MetricName")) {
                    result.metric_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricAlarm(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MetricAlarm {
    var result: MetricAlarm = undefined;
    result.actions_enabled = null;
    result.alarm_actions = null;
    result.alarm_arn = null;
    result.alarm_configuration_updated_timestamp = null;
    result.alarm_description = null;
    result.alarm_name = null;
    result.comparison_operator = null;
    result.datapoints_to_alarm = null;
    result.dimensions = null;
    result.evaluate_low_sample_count_percentile = null;
    result.evaluation_periods = null;
    result.evaluation_state = null;
    result.extended_statistic = null;
    result.insufficient_data_actions = null;
    result.metric_name = null;
    result.metrics = null;
    result.namespace = null;
    result.ok_actions = null;
    result.period = null;
    result.state_reason = null;
    result.state_reason_data = null;
    result.state_transitioned_timestamp = null;
    result.state_updated_timestamp = null;
    result.state_value = null;
    result.statistic = null;
    result.threshold = null;
    result.threshold_metric_id = null;
    result.treat_missing_data = null;
    result.unit = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActionsEnabled")) {
                    result.actions_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "AlarmActions")) {
                    result.alarm_actions = try deserializeResourceList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "AlarmArn")) {
                    result.alarm_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AlarmConfigurationUpdatedTimestamp")) {
                    result.alarm_configuration_updated_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "AlarmDescription")) {
                    result.alarm_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AlarmName")) {
                    result.alarm_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ComparisonOperator")) {
                    result.comparison_operator = std.meta.stringToEnum(ComparisonOperator, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DatapointsToAlarm")) {
                    result.datapoints_to_alarm = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Dimensions")) {
                    result.dimensions = try deserializeDimensions(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "EvaluateLowSampleCountPercentile")) {
                    result.evaluate_low_sample_count_percentile = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EvaluationPeriods")) {
                    result.evaluation_periods = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "EvaluationState")) {
                    result.evaluation_state = std.meta.stringToEnum(EvaluationState, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExtendedStatistic")) {
                    result.extended_statistic = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InsufficientDataActions")) {
                    result.insufficient_data_actions = try deserializeResourceList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "MetricName")) {
                    result.metric_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Metrics")) {
                    result.metrics = try deserializeMetricDataQueries(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OKActions")) {
                    result.ok_actions = try deserializeResourceList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Period")) {
                    result.period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "StateReason")) {
                    result.state_reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StateReasonData")) {
                    result.state_reason_data = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StateTransitionedTimestamp")) {
                    result.state_transitioned_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "StateUpdatedTimestamp")) {
                    result.state_updated_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "StateValue")) {
                    result.state_value = std.meta.stringToEnum(StateValue, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Statistic")) {
                    result.statistic = std.meta.stringToEnum(Statistic, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Threshold")) {
                    result.threshold = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ThresholdMetricId")) {
                    result.threshold_metric_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TreatMissingData")) {
                    result.treat_missing_data = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Unit")) {
                    result.unit = std.meta.stringToEnum(StandardUnit, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricCharacteristics(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MetricCharacteristics {
    _ = alloc;
    var result: MetricCharacteristics = undefined;
    result.periodic_spikes = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PeriodicSpikes")) {
                    result.periodic_spikes = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricDataQuery(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MetricDataQuery {
    var result: MetricDataQuery = undefined;
    result.account_id = null;
    result.expression = null;
    result.label = null;
    result.metric_stat = null;
    result.period = null;
    result.return_data = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccountId")) {
                    result.account_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Expression")) {
                    result.expression = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Label")) {
                    result.label = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MetricStat")) {
                    result.metric_stat = try deserializeMetricStat(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Period")) {
                    result.period = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ReturnData")) {
                    result.return_data = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricDataResult(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MetricDataResult {
    var result: MetricDataResult = undefined;
    result.id = null;
    result.label = null;
    result.messages = null;
    result.status_code = null;
    result.timestamps = null;
    result.values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Label")) {
                    result.label = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Messages")) {
                    result.messages = try deserializeMetricDataResultMessages(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "StatusCode")) {
                    result.status_code = std.meta.stringToEnum(StatusCode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Timestamps")) {
                    result.timestamps = try deserializeTimestamps(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializeDatapointValues(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricMathAnomalyDetector(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MetricMathAnomalyDetector {
    var result: MetricMathAnomalyDetector = undefined;
    result.metric_data_queries = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MetricDataQueries")) {
                    result.metric_data_queries = try deserializeMetricDataQueries(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricStat(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MetricStat {
    var result: MetricStat = undefined;
    result.unit = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Metric")) {
                    result.metric = try deserializeMetric(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Period")) {
                    result.period = try std.fmt.parseInt(i32, try reader.readElementText(), 10);
                } else if (std.mem.eql(u8, e.local, "Stat")) {
                    result.stat = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Unit")) {
                    result.unit = std.meta.stringToEnum(StandardUnit, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricStreamEntry(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MetricStreamEntry {
    var result: MetricStreamEntry = undefined;
    result.arn = null;
    result.creation_date = null;
    result.firehose_arn = null;
    result.last_update_date = null;
    result.name = null;
    result.output_format = null;
    result.state = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreationDate")) {
                    result.creation_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "FirehoseArn")) {
                    result.firehose_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastUpdateDate")) {
                    result.last_update_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OutputFormat")) {
                    result.output_format = std.meta.stringToEnum(MetricStreamOutputFormat, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricStreamFilter(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MetricStreamFilter {
    var result: MetricStreamFilter = undefined;
    result.metric_names = null;
    result.namespace = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MetricNames")) {
                    result.metric_names = try deserializeMetricStreamFilterMetricNames(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricStreamStatisticsConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MetricStreamStatisticsConfiguration {
    var result: MetricStreamStatisticsConfiguration = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AdditionalStatistics")) {
                    result.additional_statistics = try deserializeMetricStreamStatisticsAdditionalStatistics(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "IncludeMetrics")) {
                    result.include_metrics = try deserializeMetricStreamStatisticsIncludeMetrics(reader, alloc, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMetricStreamStatisticsMetric(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MetricStreamStatisticsMetric {
    var result: MetricStreamStatisticsMetric = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MetricName")) {
                    result.metric_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePartialFailure(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PartialFailure {
    var result: PartialFailure = undefined;
    result.exception_type = null;
    result.failure_code = null;
    result.failure_description = null;
    result.failure_resource = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ExceptionType")) {
                    result.exception_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FailureCode")) {
                    result.failure_code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FailureDescription")) {
                    result.failure_description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FailureResource")) {
                    result.failure_resource = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRange(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Range {
    _ = alloc;
    var result: Range = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EndTime")) {
                    result.end_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StartTime")) {
                    result.start_time = try aws.date.parseIso8601(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSingleMetricAnomalyDetector(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SingleMetricAnomalyDetector {
    var result: SingleMetricAnomalyDetector = undefined;
    result.account_id = null;
    result.dimensions = null;
    result.metric_name = null;
    result.namespace = null;
    result.stat = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccountId")) {
                    result.account_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Dimensions")) {
                    result.dimensions = try deserializeDimensions(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "MetricName")) {
                    result.metric_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Namespace")) {
                    result.namespace = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Stat")) {
                    result.stat = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTag(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Tag {
    var result: Tag = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn serializeAlarmNames(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeAlarmTypes(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const AlarmType, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, @tagName(item));
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeAnomalyDetectorExcludedTimeRanges(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Range, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeRange(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeAnomalyDetectorTypes(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const AnomalyDetectorType, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, @tagName(item));
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeCounts(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const f64, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{item}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeDashboardNames(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeDimensionFilters(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const DimensionFilter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeDimensionFilter(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeDimensions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Dimension, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeDimension(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeEntityMetricDataList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const EntityMetricData, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeEntityMetricData(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeExtendedStatistics(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeInsightRuleMetricList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeInsightRuleNames(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeManagedRules(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ManagedRule, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeManagedRule(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeMetricData(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const MetricDatum, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeMetricDatum(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeMetricDataQueries(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const MetricDataQuery, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeMetricDataQuery(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeMetricStreamFilterMetricNames(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeMetricStreamFilters(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const MetricStreamFilter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeMetricStreamFilter(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeMetricStreamNames(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeMetricStreamStatisticsAdditionalStatistics(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeMetricStreamStatisticsConfigurations(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const MetricStreamStatisticsConfiguration, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeMetricStreamStatisticsConfiguration(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeMetricStreamStatisticsIncludeMetrics(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const MetricStreamStatisticsMetric, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeMetricStreamStatisticsMetric(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeResourceList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeStatistics(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Statistic, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, @tagName(item));
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeTagKeyList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try aws.xml.appendXmlEscaped(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeTagList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Tag, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeTag(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeValues(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const f64, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{item}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeEntityAttributesMap(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.StringMapEntry, comptime entry_tag: []const u8) !void {
    for (entries) |entry| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, entry_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, "<key>");
        try aws.xml.appendXmlEscaped(alloc, buf, entry.key);
        try buf.appendSlice(alloc, "</key>");
        try buf.appendSlice(alloc, "<value>");
        try aws.xml.appendXmlEscaped(alloc, buf, entry.value);
        try buf.appendSlice(alloc, "</value>");
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, entry_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeEntityKeyAttributesMap(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.StringMapEntry, comptime entry_tag: []const u8) !void {
    for (entries) |entry| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, entry_tag);
        try buf.appendSlice(alloc, ">");
        try buf.appendSlice(alloc, "<key>");
        try aws.xml.appendXmlEscaped(alloc, buf, entry.key);
        try buf.appendSlice(alloc, "</key>");
        try buf.appendSlice(alloc, "<value>");
        try aws.xml.appendXmlEscaped(alloc, buf, entry.value);
        try buf.appendSlice(alloc, "</value>");
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, entry_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeAnomalyDetectorConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AnomalyDetectorConfiguration) !void {
    if (value.excluded_time_ranges) |v| {
        try buf.appendSlice(alloc, "<ExcludedTimeRanges>");
        try serializeAnomalyDetectorExcludedTimeRanges(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</ExcludedTimeRanges>");
    }
    if (value.metric_timezone) |v| {
        try buf.appendSlice(alloc, "<MetricTimezone>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</MetricTimezone>");
    }
}

pub fn serializeDimension(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Dimension) !void {
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
    try buf.appendSlice(alloc, "<Value>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.value);
    try buf.appendSlice(alloc, "</Value>");
}

pub fn serializeDimensionFilter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: DimensionFilter) !void {
    try buf.appendSlice(alloc, "<Name>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.name);
    try buf.appendSlice(alloc, "</Name>");
    if (value.value) |v| {
        try buf.appendSlice(alloc, "<Value>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Value>");
    }
}

pub fn serializeEntity(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Entity) !void {
    if (value.attributes) |v| {
        try buf.appendSlice(alloc, "<Attributes>");
        try serializeEntityAttributesMap(alloc, buf, v, "entry");
        try buf.appendSlice(alloc, "</Attributes>");
    }
    if (value.key_attributes) |v| {
        try buf.appendSlice(alloc, "<KeyAttributes>");
        try serializeEntityKeyAttributesMap(alloc, buf, v, "entry");
        try buf.appendSlice(alloc, "</KeyAttributes>");
    }
}

pub fn serializeEntityMetricData(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: EntityMetricData) !void {
    if (value.entity) |v| {
        try buf.appendSlice(alloc, "<Entity>");
        try serializeEntity(alloc, buf, v);
        try buf.appendSlice(alloc, "</Entity>");
    }
    if (value.metric_data) |v| {
        try buf.appendSlice(alloc, "<MetricData>");
        try serializeMetricData(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</MetricData>");
    }
}

pub fn serializeLabelOptions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: LabelOptions) !void {
    if (value.timezone) |v| {
        try buf.appendSlice(alloc, "<Timezone>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Timezone>");
    }
}

pub fn serializeManagedRule(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ManagedRule) !void {
    try buf.appendSlice(alloc, "<ResourceARN>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.resource_arn);
    try buf.appendSlice(alloc, "</ResourceARN>");
    if (value.tags) |v| {
        try buf.appendSlice(alloc, "<Tags>");
        try serializeTagList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Tags>");
    }
    try buf.appendSlice(alloc, "<TemplateName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.template_name);
    try buf.appendSlice(alloc, "</TemplateName>");
}

pub fn serializeMetric(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Metric) !void {
    if (value.dimensions) |v| {
        try buf.appendSlice(alloc, "<Dimensions>");
        try serializeDimensions(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Dimensions>");
    }
    if (value.metric_name) |v| {
        try buf.appendSlice(alloc, "<MetricName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</MetricName>");
    }
    if (value.namespace) |v| {
        try buf.appendSlice(alloc, "<Namespace>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Namespace>");
    }
}

pub fn serializeMetricCharacteristics(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricCharacteristics) !void {
    if (value.periodic_spikes) |v| {
        try buf.appendSlice(alloc, "<PeriodicSpikes>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</PeriodicSpikes>");
    }
}

pub fn serializeMetricDataQuery(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricDataQuery) !void {
    if (value.account_id) |v| {
        try buf.appendSlice(alloc, "<AccountId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</AccountId>");
    }
    if (value.expression) |v| {
        try buf.appendSlice(alloc, "<Expression>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Expression>");
    }
    try buf.appendSlice(alloc, "<Id>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.id);
    try buf.appendSlice(alloc, "</Id>");
    if (value.label) |v| {
        try buf.appendSlice(alloc, "<Label>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Label>");
    }
    if (value.metric_stat) |v| {
        try buf.appendSlice(alloc, "<MetricStat>");
        try serializeMetricStat(alloc, buf, v);
        try buf.appendSlice(alloc, "</MetricStat>");
    }
    if (value.period) |v| {
        try buf.appendSlice(alloc, "<Period>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Period>");
    }
    if (value.return_data) |v| {
        try buf.appendSlice(alloc, "<ReturnData>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</ReturnData>");
    }
}

pub fn serializeMetricDatum(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricDatum) !void {
    if (value.counts) |v| {
        try buf.appendSlice(alloc, "<Counts>");
        try serializeCounts(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Counts>");
    }
    if (value.dimensions) |v| {
        try buf.appendSlice(alloc, "<Dimensions>");
        try serializeDimensions(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Dimensions>");
    }
    try buf.appendSlice(alloc, "<MetricName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.metric_name);
    try buf.appendSlice(alloc, "</MetricName>");
    if (value.statistic_values) |v| {
        try buf.appendSlice(alloc, "<StatisticValues>");
        try serializeStatisticSet(alloc, buf, v);
        try buf.appendSlice(alloc, "</StatisticValues>");
    }
    if (value.storage_resolution) |v| {
        try buf.appendSlice(alloc, "<StorageResolution>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</StorageResolution>");
    }
    if (value.timestamp) |v| {
        try buf.appendSlice(alloc, "<Timestamp>");
        {
            const ts_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, ts_str);
        }
        try buf.appendSlice(alloc, "</Timestamp>");
    }
    if (value.unit) |v| {
        try buf.appendSlice(alloc, "<Unit>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</Unit>");
    }
    if (value.value) |v| {
        try buf.appendSlice(alloc, "<Value>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</Value>");
    }
    if (value.values) |v| {
        try buf.appendSlice(alloc, "<Values>");
        try serializeValues(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Values>");
    }
}

pub fn serializeMetricMathAnomalyDetector(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricMathAnomalyDetector) !void {
    if (value.metric_data_queries) |v| {
        try buf.appendSlice(alloc, "<MetricDataQueries>");
        try serializeMetricDataQueries(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</MetricDataQueries>");
    }
}

pub fn serializeMetricStat(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricStat) !void {
    try buf.appendSlice(alloc, "<Metric>");
    try serializeMetric(alloc, buf, value.metric);
    try buf.appendSlice(alloc, "</Metric>");
    try buf.appendSlice(alloc, "<Period>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.period}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Period>");
    try buf.appendSlice(alloc, "<Stat>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.stat);
    try buf.appendSlice(alloc, "</Stat>");
    if (value.unit) |v| {
        try buf.appendSlice(alloc, "<Unit>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</Unit>");
    }
}

pub fn serializeMetricStreamFilter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricStreamFilter) !void {
    if (value.metric_names) |v| {
        try buf.appendSlice(alloc, "<MetricNames>");
        try serializeMetricStreamFilterMetricNames(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</MetricNames>");
    }
    if (value.namespace) |v| {
        try buf.appendSlice(alloc, "<Namespace>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Namespace>");
    }
}

pub fn serializeMetricStreamStatisticsConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricStreamStatisticsConfiguration) !void {
    try buf.appendSlice(alloc, "<AdditionalStatistics>");
    try serializeMetricStreamStatisticsAdditionalStatistics(alloc, buf, value.additional_statistics, "member");
    try buf.appendSlice(alloc, "</AdditionalStatistics>");
    try buf.appendSlice(alloc, "<IncludeMetrics>");
    try serializeMetricStreamStatisticsIncludeMetrics(alloc, buf, value.include_metrics, "member");
    try buf.appendSlice(alloc, "</IncludeMetrics>");
}

pub fn serializeMetricStreamStatisticsMetric(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: MetricStreamStatisticsMetric) !void {
    try buf.appendSlice(alloc, "<MetricName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.metric_name);
    try buf.appendSlice(alloc, "</MetricName>");
    try buf.appendSlice(alloc, "<Namespace>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.namespace);
    try buf.appendSlice(alloc, "</Namespace>");
}

pub fn serializeRange(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Range) !void {
    try buf.appendSlice(alloc, "<EndTime>");
    {
        const ts_str = std.fmt.allocPrint(alloc, "{d}", .{value.end_time}) catch "";
        try buf.appendSlice(alloc, ts_str);
    }
    try buf.appendSlice(alloc, "</EndTime>");
    try buf.appendSlice(alloc, "<StartTime>");
    {
        const ts_str = std.fmt.allocPrint(alloc, "{d}", .{value.start_time}) catch "";
        try buf.appendSlice(alloc, ts_str);
    }
    try buf.appendSlice(alloc, "</StartTime>");
}

pub fn serializeSingleMetricAnomalyDetector(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: SingleMetricAnomalyDetector) !void {
    if (value.account_id) |v| {
        try buf.appendSlice(alloc, "<AccountId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</AccountId>");
    }
    if (value.dimensions) |v| {
        try buf.appendSlice(alloc, "<Dimensions>");
        try serializeDimensions(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Dimensions>");
    }
    if (value.metric_name) |v| {
        try buf.appendSlice(alloc, "<MetricName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</MetricName>");
    }
    if (value.namespace) |v| {
        try buf.appendSlice(alloc, "<Namespace>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Namespace>");
    }
    if (value.stat) |v| {
        try buf.appendSlice(alloc, "<Stat>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Stat>");
    }
}

pub fn serializeStatisticSet(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StatisticSet) !void {
    try buf.appendSlice(alloc, "<Maximum>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.maximum}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Maximum>");
    try buf.appendSlice(alloc, "<Minimum>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.minimum}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Minimum>");
    try buf.appendSlice(alloc, "<SampleCount>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.sample_count}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</SampleCount>");
    try buf.appendSlice(alloc, "<Sum>");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{value.sum}) catch "";
        try buf.appendSlice(alloc, num_str);
    }
    try buf.appendSlice(alloc, "</Sum>");
}

pub fn serializeTag(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tag) !void {
    try buf.appendSlice(alloc, "<Key>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.key);
    try buf.appendSlice(alloc, "</Key>");
    try buf.appendSlice(alloc, "<Value>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.value);
    try buf.appendSlice(alloc, "</Value>");
}
