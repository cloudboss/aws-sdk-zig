const aws = @import("aws");
const std = @import("std");

const AccountFilterType = @import("account_filter_type.zig").AccountFilterType;
const AccountGateResult = @import("account_gate_result.zig").AccountGateResult;
const AccountGateStatus = @import("account_gate_status.zig").AccountGateStatus;
const AccountLimit = @import("account_limit.zig").AccountLimit;
const AfterValueFrom = @import("after_value_from.zig").AfterValueFrom;
const Annotation = @import("annotation.zig").Annotation;
const AnnotationSeverityLevel = @import("annotation_severity_level.zig").AnnotationSeverityLevel;
const AnnotationStatus = @import("annotation_status.zig").AnnotationStatus;
const AttributeChangeType = @import("attribute_change_type.zig").AttributeChangeType;
const AutoDeployment = @import("auto_deployment.zig").AutoDeployment;
const BatchDescribeTypeConfigurationsError = @import("batch_describe_type_configurations_error.zig").BatchDescribeTypeConfigurationsError;
const BeaconStackOperationStatus = @import("beacon_stack_operation_status.zig").BeaconStackOperationStatus;
const BeforeValueFrom = @import("before_value_from.zig").BeforeValueFrom;
const Capability = @import("capability.zig").Capability;
const Category = @import("category.zig").Category;
const Change = @import("change.zig").Change;
const ChangeAction = @import("change_action.zig").ChangeAction;
const ChangeSetHook = @import("change_set_hook.zig").ChangeSetHook;
const ChangeSetHookResourceTargetDetails = @import("change_set_hook_resource_target_details.zig").ChangeSetHookResourceTargetDetails;
const ChangeSetHookTargetDetails = @import("change_set_hook_target_details.zig").ChangeSetHookTargetDetails;
const ChangeSetStatus = @import("change_set_status.zig").ChangeSetStatus;
const ChangeSetSummary = @import("change_set_summary.zig").ChangeSetSummary;
const ChangeSource = @import("change_source.zig").ChangeSource;
const ChangeType = @import("change_type.zig").ChangeType;
const ConcurrencyMode = @import("concurrency_mode.zig").ConcurrencyMode;
const DeletionMode = @import("deletion_mode.zig").DeletionMode;
const DeploymentTargets = @import("deployment_targets.zig").DeploymentTargets;
const DetailedStatus = @import("detailed_status.zig").DetailedStatus;
const DifferenceType = @import("difference_type.zig").DifferenceType;
const DriftIgnoredReason = @import("drift_ignored_reason.zig").DriftIgnoredReason;
const EvaluationType = @import("evaluation_type.zig").EvaluationType;
const EventFilter = @import("event_filter.zig").EventFilter;
const EventType = @import("event_type.zig").EventType;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const Export = @import("export.zig").Export;
const GeneratedTemplateDeletionPolicy = @import("generated_template_deletion_policy.zig").GeneratedTemplateDeletionPolicy;
const GeneratedTemplateResourceStatus = @import("generated_template_resource_status.zig").GeneratedTemplateResourceStatus;
const GeneratedTemplateStatus = @import("generated_template_status.zig").GeneratedTemplateStatus;
const GeneratedTemplateUpdateReplacePolicy = @import("generated_template_update_replace_policy.zig").GeneratedTemplateUpdateReplacePolicy;
const HookFailureMode = @import("hook_failure_mode.zig").HookFailureMode;
const HookInvocationPoint = @import("hook_invocation_point.zig").HookInvocationPoint;
const HookResultSummary = @import("hook_result_summary.zig").HookResultSummary;
const HookStatus = @import("hook_status.zig").HookStatus;
const HookTarget = @import("hook_target.zig").HookTarget;
const HookTargetAction = @import("hook_target_action.zig").HookTargetAction;
const HookTargetType = @import("hook_target_type.zig").HookTargetType;
const IdentityProvider = @import("identity_provider.zig").IdentityProvider;
const ListHookResultsTargetType = @import("list_hook_results_target_type.zig").ListHookResultsTargetType;
const LiveResourceDrift = @import("live_resource_drift.zig").LiveResourceDrift;
const LoggingConfig = @import("logging_config.zig").LoggingConfig;
const ManagedExecution = @import("managed_execution.zig").ManagedExecution;
const ModuleInfo = @import("module_info.zig").ModuleInfo;
const OperationEntry = @import("operation_entry.zig").OperationEntry;
const OperationEvent = @import("operation_event.zig").OperationEvent;
const OperationResultFilter = @import("operation_result_filter.zig").OperationResultFilter;
const OperationResultFilterName = @import("operation_result_filter_name.zig").OperationResultFilterName;
const OperationType = @import("operation_type.zig").OperationType;
const Output = @import("output.zig").Output;
const Parameter = @import("parameter.zig").Parameter;
const ParameterConstraints = @import("parameter_constraints.zig").ParameterConstraints;
const ParameterDeclaration = @import("parameter_declaration.zig").ParameterDeclaration;
const PermissionModels = @import("permission_models.zig").PermissionModels;
const PhysicalResourceIdContextKeyValuePair = @import("physical_resource_id_context_key_value_pair.zig").PhysicalResourceIdContextKeyValuePair;
const PolicyAction = @import("policy_action.zig").PolicyAction;
const PropertyDifference = @import("property_difference.zig").PropertyDifference;
const RegionConcurrencyType = @import("region_concurrency_type.zig").RegionConcurrencyType;
const RegistryType = @import("registry_type.zig").RegistryType;
const Replacement = @import("replacement.zig").Replacement;
const RequiredActivatedType = @import("required_activated_type.zig").RequiredActivatedType;
const RequiresRecreation = @import("requires_recreation.zig").RequiresRecreation;
const ResourceAttribute = @import("resource_attribute.zig").ResourceAttribute;
const ResourceChange = @import("resource_change.zig").ResourceChange;
const ResourceChangeDetail = @import("resource_change_detail.zig").ResourceChangeDetail;
const ResourceDefinition = @import("resource_definition.zig").ResourceDefinition;
const ResourceDetail = @import("resource_detail.zig").ResourceDetail;
const ResourceDriftIgnoredAttribute = @import("resource_drift_ignored_attribute.zig").ResourceDriftIgnoredAttribute;
const ResourceIdentifierSummary = @import("resource_identifier_summary.zig").ResourceIdentifierSummary;
const ResourceLocation = @import("resource_location.zig").ResourceLocation;
const ResourceMapping = @import("resource_mapping.zig").ResourceMapping;
const ResourceScanStatus = @import("resource_scan_status.zig").ResourceScanStatus;
const ResourceScanSummary = @import("resource_scan_summary.zig").ResourceScanSummary;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;
const ResourceTargetDefinition = @import("resource_target_definition.zig").ResourceTargetDefinition;
const ResourceToImport = @import("resource_to_import.zig").ResourceToImport;
const RollbackConfiguration = @import("rollback_configuration.zig").RollbackConfiguration;
const RollbackTrigger = @import("rollback_trigger.zig").RollbackTrigger;
const ScanFilter = @import("scan_filter.zig").ScanFilter;
const ScanType = @import("scan_type.zig").ScanType;
const ScannedResource = @import("scanned_resource.zig").ScannedResource;
const ScannedResourceIdentifier = @import("scanned_resource_identifier.zig").ScannedResourceIdentifier;
const Stack = @import("stack.zig").Stack;
const StackDefinition = @import("stack_definition.zig").StackDefinition;
const StackDriftInformation = @import("stack_drift_information.zig").StackDriftInformation;
const StackDriftInformationSummary = @import("stack_drift_information_summary.zig").StackDriftInformationSummary;
const StackDriftStatus = @import("stack_drift_status.zig").StackDriftStatus;
const StackEvent = @import("stack_event.zig").StackEvent;
const StackInstance = @import("stack_instance.zig").StackInstance;
const StackInstanceComprehensiveStatus = @import("stack_instance_comprehensive_status.zig").StackInstanceComprehensiveStatus;
const StackInstanceDetailedStatus = @import("stack_instance_detailed_status.zig").StackInstanceDetailedStatus;
const StackInstanceFilter = @import("stack_instance_filter.zig").StackInstanceFilter;
const StackInstanceFilterName = @import("stack_instance_filter_name.zig").StackInstanceFilterName;
const StackInstanceResourceDriftsSummary = @import("stack_instance_resource_drifts_summary.zig").StackInstanceResourceDriftsSummary;
const StackInstanceStatus = @import("stack_instance_status.zig").StackInstanceStatus;
const StackInstanceSummary = @import("stack_instance_summary.zig").StackInstanceSummary;
const StackRefactorAction = @import("stack_refactor_action.zig").StackRefactorAction;
const StackRefactorActionEntity = @import("stack_refactor_action_entity.zig").StackRefactorActionEntity;
const StackRefactorActionType = @import("stack_refactor_action_type.zig").StackRefactorActionType;
const StackRefactorDetection = @import("stack_refactor_detection.zig").StackRefactorDetection;
const StackRefactorExecutionStatus = @import("stack_refactor_execution_status.zig").StackRefactorExecutionStatus;
const StackRefactorStatus = @import("stack_refactor_status.zig").StackRefactorStatus;
const StackRefactorSummary = @import("stack_refactor_summary.zig").StackRefactorSummary;
const StackResource = @import("stack_resource.zig").StackResource;
const StackResourceDetail = @import("stack_resource_detail.zig").StackResourceDetail;
const StackResourceDrift = @import("stack_resource_drift.zig").StackResourceDrift;
const StackResourceDriftInformation = @import("stack_resource_drift_information.zig").StackResourceDriftInformation;
const StackResourceDriftInformationSummary = @import("stack_resource_drift_information_summary.zig").StackResourceDriftInformationSummary;
const StackResourceDriftStatus = @import("stack_resource_drift_status.zig").StackResourceDriftStatus;
const StackResourceSummary = @import("stack_resource_summary.zig").StackResourceSummary;
const StackSet = @import("stack_set.zig").StackSet;
const StackSetAutoDeploymentTargetSummary = @import("stack_set_auto_deployment_target_summary.zig").StackSetAutoDeploymentTargetSummary;
const StackSetDriftDetectionDetails = @import("stack_set_drift_detection_details.zig").StackSetDriftDetectionDetails;
const StackSetDriftDetectionStatus = @import("stack_set_drift_detection_status.zig").StackSetDriftDetectionStatus;
const StackSetDriftStatus = @import("stack_set_drift_status.zig").StackSetDriftStatus;
const StackSetOperation = @import("stack_set_operation.zig").StackSetOperation;
const StackSetOperationAction = @import("stack_set_operation_action.zig").StackSetOperationAction;
const StackSetOperationPreferences = @import("stack_set_operation_preferences.zig").StackSetOperationPreferences;
const StackSetOperationResultStatus = @import("stack_set_operation_result_status.zig").StackSetOperationResultStatus;
const StackSetOperationResultSummary = @import("stack_set_operation_result_summary.zig").StackSetOperationResultSummary;
const StackSetOperationStatus = @import("stack_set_operation_status.zig").StackSetOperationStatus;
const StackSetOperationStatusDetails = @import("stack_set_operation_status_details.zig").StackSetOperationStatusDetails;
const StackSetOperationSummary = @import("stack_set_operation_summary.zig").StackSetOperationSummary;
const StackSetStatus = @import("stack_set_status.zig").StackSetStatus;
const StackSetSummary = @import("stack_set_summary.zig").StackSetSummary;
const StackStatus = @import("stack_status.zig").StackStatus;
const StackSummary = @import("stack_summary.zig").StackSummary;
const Tag = @import("tag.zig").Tag;
const TemplateConfiguration = @import("template_configuration.zig").TemplateConfiguration;
const TemplateParameter = @import("template_parameter.zig").TemplateParameter;
const TemplateProgress = @import("template_progress.zig").TemplateProgress;
const TemplateStage = @import("template_stage.zig").TemplateStage;
const TemplateSummary = @import("template_summary.zig").TemplateSummary;
const TemplateSummaryConfig = @import("template_summary_config.zig").TemplateSummaryConfig;
const ThirdPartyType = @import("third_party_type.zig").ThirdPartyType;
const TypeConfigurationDetails = @import("type_configuration_details.zig").TypeConfigurationDetails;
const TypeConfigurationIdentifier = @import("type_configuration_identifier.zig").TypeConfigurationIdentifier;
const TypeFilters = @import("type_filters.zig").TypeFilters;
const TypeSummary = @import("type_summary.zig").TypeSummary;
const TypeVersionSummary = @import("type_version_summary.zig").TypeVersionSummary;
const ValidationStatus = @import("validation_status.zig").ValidationStatus;
const WarningDetail = @import("warning_detail.zig").WarningDetail;
const WarningProperty = @import("warning_property.zig").WarningProperty;
const WarningType = @import("warning_type.zig").WarningType;
const Warnings = @import("warnings.zig").Warnings;

pub fn deserializeAccountLimitList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AccountLimit {
    var list: std.ArrayList(AccountLimit) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAccountLimit(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAccountList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAllowedValues(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAnnotationList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Annotation {
    var list: std.ArrayList(Annotation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAnnotation(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeBatchDescribeTypeConfigurationsErrors(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const BatchDescribeTypeConfigurationsError {
    var list: std.ArrayList(BatchDescribeTypeConfigurationsError) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeBatchDescribeTypeConfigurationsError(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeCapabilities(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Capability {
    var list: std.ArrayList(Capability) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(Capability, try reader.readElementText())) |v| try list.append(allocator, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeChangeSetHooks(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ChangeSetHook {
    var list: std.ArrayList(ChangeSetHook) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeChangeSetHook(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeChangeSetSummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ChangeSetSummary {
    var list: std.ArrayList(ChangeSetSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeChangeSetSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeChanges(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Change {
    var list: std.ArrayList(Change) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeChange(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeExports(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Export {
    var list: std.ArrayList(Export) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeExport(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeHookResultSummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const HookResultSummary {
    var list: std.ArrayList(HookResultSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeHookResultSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeImports(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeLastOperations(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const OperationEntry {
    var list: std.ArrayList(OperationEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeOperationEntry(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeLogicalResourceIds(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeNotificationARNs(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOperationEvents(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const OperationEvent {
    var list: std.ArrayList(OperationEvent) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeOperationEvent(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOrganizationalUnitIdList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOutputs(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Output {
    var list: std.ArrayList(Output) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeOutput(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeParameterDeclarations(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ParameterDeclaration {
    var list: std.ArrayList(ParameterDeclaration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeParameterDeclaration(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeParameters(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Parameter {
    var list: std.ArrayList(Parameter) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeParameter(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializePhysicalResourceIdContext(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PhysicalResourceIdContextKeyValuePair {
    var list: std.ArrayList(PhysicalResourceIdContextKeyValuePair) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePhysicalResourceIdContextKeyValuePair(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializePropertyDifferences(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PropertyDifference {
    var list: std.ArrayList(PropertyDifference) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePropertyDifference(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeRegionList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeRegistrationTokenList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeRelatedResources(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ScannedResource {
    var list: std.ArrayList(ScannedResource) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeScannedResource(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeRequiredActivatedTypes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const RequiredActivatedType {
    var list: std.ArrayList(RequiredActivatedType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeRequiredActivatedType(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeResourceChangeDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ResourceChangeDetail {
    var list: std.ArrayList(ResourceChangeDetail) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeResourceChangeDetail(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeResourceDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ResourceDetail {
    var list: std.ArrayList(ResourceDetail) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeResourceDetail(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeResourceDriftIgnoredAttributes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ResourceDriftIgnoredAttribute {
    var list: std.ArrayList(ResourceDriftIgnoredAttribute) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeResourceDriftIgnoredAttribute(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeResourceIdentifierSummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ResourceIdentifierSummary {
    var list: std.ArrayList(ResourceIdentifierSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeResourceIdentifierSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeResourceIdentifiers(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeResourceScanSummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ResourceScanSummary {
    var list: std.ArrayList(ResourceScanSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeResourceScanSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeResourceTypeFilters(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeResourceTypes(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeRollbackTriggers(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const RollbackTrigger {
    var list: std.ArrayList(RollbackTrigger) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeRollbackTrigger(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeScanFilters(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ScanFilter {
    var list: std.ArrayList(ScanFilter) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeScanFilter(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeScannedResources(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ScannedResource {
    var list: std.ArrayList(ScannedResource) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeScannedResource(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeScope(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ResourceAttribute {
    var list: std.ArrayList(ResourceAttribute) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(ResourceAttribute, try reader.readElementText())) |v| try list.append(allocator, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStackEvents(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const StackEvent {
    var list: std.ArrayList(StackEvent) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeStackEvent(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStackIds(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStackInstanceResourceDriftsSummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const StackInstanceResourceDriftsSummary {
    var list: std.ArrayList(StackInstanceResourceDriftsSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeStackInstanceResourceDriftsSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStackInstanceSummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const StackInstanceSummary {
    var list: std.ArrayList(StackInstanceSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeStackInstanceSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStackRefactorActions(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const StackRefactorAction {
    var list: std.ArrayList(StackRefactorAction) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeStackRefactorAction(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStackRefactorSummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const StackRefactorSummary {
    var list: std.ArrayList(StackRefactorSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeStackRefactorSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStackRefactorTagResources(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Tag {
    var list: std.ArrayList(Tag) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTag(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStackRefactorUntagResources(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStackResourceDrifts(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const StackResourceDrift {
    var list: std.ArrayList(StackResourceDrift) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeStackResourceDrift(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStackResourceSummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const StackResourceSummary {
    var list: std.ArrayList(StackResourceSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeStackResourceSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStackResources(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const StackResource {
    var list: std.ArrayList(StackResource) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeStackResource(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStackSetARNList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStackSetAutoDeploymentTargetSummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const StackSetAutoDeploymentTargetSummary {
    var list: std.ArrayList(StackSetAutoDeploymentTargetSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeStackSetAutoDeploymentTargetSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStackSetOperationResultSummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const StackSetOperationResultSummary {
    var list: std.ArrayList(StackSetOperationResultSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeStackSetOperationResultSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStackSetOperationSummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const StackSetOperationSummary {
    var list: std.ArrayList(StackSetOperationSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeStackSetOperationSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStackSetSummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const StackSetSummary {
    var list: std.ArrayList(StackSetSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeStackSetSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStackSummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const StackSummary {
    var list: std.ArrayList(StackSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeStackSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStacks(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Stack {
    var list: std.ArrayList(Stack) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeStack(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStageList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TemplateStage {
    var list: std.ArrayList(TemplateStage) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(TemplateStage, try reader.readElementText())) |v| try list.append(allocator, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeSupportedMajorVersions(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const i32 {
    var list: std.ArrayList(i32) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null) |v| try list.append(allocator, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTags(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Tag {
    var list: std.ArrayList(Tag) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTag(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTemplateParameters(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TemplateParameter {
    var list: std.ArrayList(TemplateParameter) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTemplateParameter(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTemplateSummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TemplateSummary {
    var list: std.ArrayList(TemplateSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTemplateSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTransformsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTypeConfigurationDetailsList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TypeConfigurationDetails {
    var list: std.ArrayList(TypeConfigurationDetails) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTypeConfigurationDetails(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTypeSummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TypeSummary {
    var list: std.ArrayList(TypeSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTypeSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTypeVersionSummaries(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TypeVersionSummary {
    var list: std.ArrayList(TypeVersionSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTypeVersionSummary(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeUnprocessedTypeConfigurations(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TypeConfigurationIdentifier {
    var list: std.ArrayList(TypeConfigurationIdentifier) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTypeConfigurationIdentifier(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeWarningDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const WarningDetail {
    var list: std.ArrayList(WarningDetail) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeWarningDetail(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeWarningProperties(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const WarningProperty {
    var list: std.ArrayList(WarningProperty) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeWarningProperty(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeJazzResourceIdentifierProperties(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
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
                                    entry_key = try allocator.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try allocator.dupe(u8, try reader.readElementText());
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(allocator, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeResourceIdentifierProperties(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
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
                                    entry_key = try allocator.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try allocator.dupe(u8, try reader.readElementText());
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(allocator, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAccountGateResult(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AccountGateResult {
    var result: AccountGateResult = undefined;
    result.status = null;
    result.status_reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(AccountGateStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeAccountLimit(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AccountLimit {
    var result: AccountLimit = undefined;
    result.name = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

pub fn deserializeAnnotation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Annotation {
    var result: Annotation = undefined;
    result.annotation_name = null;
    result.remediation_link = null;
    result.remediation_message = null;
    result.severity_level = null;
    result.status = null;
    result.status_message = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AnnotationName")) {
                    result.annotation_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RemediationLink")) {
                    result.remediation_link = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RemediationMessage")) {
                    result.remediation_message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SeverityLevel")) {
                    result.severity_level = std.meta.stringToEnum(AnnotationSeverityLevel, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(AnnotationStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusMessage")) {
                    result.status_message = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeAutoDeployment(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AutoDeployment {
    var result: AutoDeployment = undefined;
    result.depends_on = null;
    result.enabled = null;
    result.retain_stacks_on_account_removal = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DependsOn")) {
                    result.depends_on = try deserializeStackSetARNList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Enabled")) {
                    result.enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "RetainStacksOnAccountRemoval")) {
                    result.retain_stacks_on_account_removal = std.mem.eql(u8, try reader.readElementText(), "true");
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

pub fn deserializeBatchDescribeTypeConfigurationsError(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !BatchDescribeTypeConfigurationsError {
    var result: BatchDescribeTypeConfigurationsError = undefined;
    result.error_code = null;
    result.error_message = null;
    result.type_configuration_identifier = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ErrorCode")) {
                    result.error_code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ErrorMessage")) {
                    result.error_message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeConfigurationIdentifier")) {
                    result.type_configuration_identifier = try deserializeTypeConfigurationIdentifier(allocator, reader);
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

pub fn deserializeChange(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Change {
    var result: Change = undefined;
    result.hook_invocation_count = null;
    result.resource_change = null;
    result.@"type" = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HookInvocationCount")) {
                    result.hook_invocation_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ResourceChange")) {
                    result.resource_change = try deserializeResourceChange(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(ChangeType, try reader.readElementText());
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

pub fn deserializeChangeSetHook(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ChangeSetHook {
    var result: ChangeSetHook = undefined;
    result.failure_mode = null;
    result.invocation_point = null;
    result.target_details = null;
    result.type_configuration_version_id = null;
    result.type_name = null;
    result.type_version_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FailureMode")) {
                    result.failure_mode = std.meta.stringToEnum(HookFailureMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InvocationPoint")) {
                    result.invocation_point = std.meta.stringToEnum(HookInvocationPoint, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetDetails")) {
                    result.target_details = try deserializeChangeSetHookTargetDetails(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "TypeConfigurationVersionId")) {
                    result.type_configuration_version_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeName")) {
                    result.type_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeVersionId")) {
                    result.type_version_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeChangeSetHookResourceTargetDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ChangeSetHookResourceTargetDetails {
    var result: ChangeSetHookResourceTargetDetails = undefined;
    result.logical_resource_id = null;
    result.resource_action = null;
    result.resource_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LogicalResourceId")) {
                    result.logical_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceAction")) {
                    result.resource_action = std.meta.stringToEnum(ChangeAction, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeChangeSetHookTargetDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ChangeSetHookTargetDetails {
    var result: ChangeSetHookTargetDetails = undefined;
    result.resource_target_details = null;
    result.target_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ResourceTargetDetails")) {
                    result.resource_target_details = try deserializeChangeSetHookResourceTargetDetails(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "TargetType")) {
                    result.target_type = std.meta.stringToEnum(HookTargetType, try reader.readElementText());
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

pub fn deserializeChangeSetSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ChangeSetSummary {
    var result: ChangeSetSummary = undefined;
    result.change_set_id = null;
    result.change_set_name = null;
    result.creation_time = null;
    result.description = null;
    result.execution_status = null;
    result.import_existing_resources = null;
    result.include_nested_stacks = null;
    result.parent_change_set_id = null;
    result.root_change_set_id = null;
    result.stack_id = null;
    result.stack_name = null;
    result.status = null;
    result.status_reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ChangeSetId")) {
                    result.change_set_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChangeSetName")) {
                    result.change_set_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreationTime")) {
                    result.creation_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExecutionStatus")) {
                    result.execution_status = std.meta.stringToEnum(ExecutionStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ImportExistingResources")) {
                    result.import_existing_resources = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IncludeNestedStacks")) {
                    result.include_nested_stacks = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ParentChangeSetId")) {
                    result.parent_change_set_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RootChangeSetId")) {
                    result.root_change_set_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackName")) {
                    result.stack_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(ChangeSetStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeDeploymentTargets(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DeploymentTargets {
    var result: DeploymentTargets = undefined;
    result.account_filter_type = null;
    result.accounts = null;
    result.accounts_url = null;
    result.organizational_unit_ids = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccountFilterType")) {
                    result.account_filter_type = std.meta.stringToEnum(AccountFilterType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Accounts")) {
                    result.accounts = try deserializeAccountList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "AccountsUrl")) {
                    result.accounts_url = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OrganizationalUnitIds")) {
                    result.organizational_unit_ids = try deserializeOrganizationalUnitIdList(allocator, reader, "member");
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

pub fn deserializeExport(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Export {
    var result: Export = undefined;
    result.exporting_stack_id = null;
    result.name = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ExportingStackId")) {
                    result.exporting_stack_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeHookResultSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !HookResultSummary {
    var result: HookResultSummary = undefined;
    result.failure_mode = null;
    result.hook_execution_target = null;
    result.hook_result_id = null;
    result.hook_status_reason = null;
    result.invocation_point = null;
    result.invoked_at = null;
    result.status = null;
    result.target_id = null;
    result.target_type = null;
    result.type_arn = null;
    result.type_configuration_version_id = null;
    result.type_name = null;
    result.type_version_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FailureMode")) {
                    result.failure_mode = std.meta.stringToEnum(HookFailureMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookExecutionTarget")) {
                    result.hook_execution_target = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookResultId")) {
                    result.hook_result_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookStatusReason")) {
                    result.hook_status_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InvocationPoint")) {
                    result.invocation_point = std.meta.stringToEnum(HookInvocationPoint, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InvokedAt")) {
                    result.invoked_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(HookStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetId")) {
                    result.target_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetType")) {
                    result.target_type = std.meta.stringToEnum(ListHookResultsTargetType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeArn")) {
                    result.type_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeConfigurationVersionId")) {
                    result.type_configuration_version_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeName")) {
                    result.type_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeVersionId")) {
                    result.type_version_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeHookTarget(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !HookTarget {
    var result: HookTarget = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Action")) {
                    result.action = std.meta.stringToEnum(HookTargetAction, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetId")) {
                    result.target_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetType")) {
                    result.target_type = std.meta.stringToEnum(HookTargetType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetTypeName")) {
                    result.target_type_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeLiveResourceDrift(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LiveResourceDrift {
    var result: LiveResourceDrift = undefined;
    result.actual_value = null;
    result.drift_detection_timestamp = null;
    result.previous_value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActualValue")) {
                    result.actual_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DriftDetectionTimestamp")) {
                    result.drift_detection_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "PreviousValue")) {
                    result.previous_value = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeLoggingConfig(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LoggingConfig {
    var result: LoggingConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LogGroupName")) {
                    result.log_group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogRoleArn")) {
                    result.log_role_arn = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeManagedExecution(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ManagedExecution {
    _ = allocator;
    var result: ManagedExecution = undefined;
    result.active = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Active")) {
                    result.active = std.mem.eql(u8, try reader.readElementText(), "true");
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

pub fn deserializeModuleInfo(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ModuleInfo {
    var result: ModuleInfo = undefined;
    result.logical_id_hierarchy = null;
    result.type_hierarchy = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LogicalIdHierarchy")) {
                    result.logical_id_hierarchy = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeHierarchy")) {
                    result.type_hierarchy = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeOperationEntry(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OperationEntry {
    var result: OperationEntry = undefined;
    result.operation_id = null;
    result.operation_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OperationId")) {
                    result.operation_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperationType")) {
                    result.operation_type = std.meta.stringToEnum(OperationType, try reader.readElementText());
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

pub fn deserializeOperationEvent(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OperationEvent {
    var result: OperationEvent = undefined;
    result.client_request_token = null;
    result.detailed_status = null;
    result.end_time = null;
    result.event_id = null;
    result.event_type = null;
    result.hook_failure_mode = null;
    result.hook_invocation_point = null;
    result.hook_status = null;
    result.hook_status_reason = null;
    result.hook_type = null;
    result.logical_resource_id = null;
    result.operation_id = null;
    result.operation_status = null;
    result.operation_type = null;
    result.physical_resource_id = null;
    result.resource_properties = null;
    result.resource_status = null;
    result.resource_status_reason = null;
    result.resource_type = null;
    result.stack_id = null;
    result.start_time = null;
    result.timestamp = null;
    result.validation_failure_mode = null;
    result.validation_name = null;
    result.validation_path = null;
    result.validation_status = null;
    result.validation_status_reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ClientRequestToken")) {
                    result.client_request_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DetailedStatus")) {
                    result.detailed_status = std.meta.stringToEnum(DetailedStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndTime")) {
                    result.end_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "EventId")) {
                    result.event_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EventType")) {
                    result.event_type = std.meta.stringToEnum(EventType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookFailureMode")) {
                    result.hook_failure_mode = std.meta.stringToEnum(HookFailureMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookInvocationPoint")) {
                    result.hook_invocation_point = std.meta.stringToEnum(HookInvocationPoint, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookStatus")) {
                    result.hook_status = std.meta.stringToEnum(HookStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookStatusReason")) {
                    result.hook_status_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookType")) {
                    result.hook_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogicalResourceId")) {
                    result.logical_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperationId")) {
                    result.operation_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperationStatus")) {
                    result.operation_status = std.meta.stringToEnum(BeaconStackOperationStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperationType")) {
                    result.operation_type = std.meta.stringToEnum(OperationType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PhysicalResourceId")) {
                    result.physical_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceProperties")) {
                    result.resource_properties = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceStatus")) {
                    result.resource_status = std.meta.stringToEnum(ResourceStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceStatusReason")) {
                    result.resource_status_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StartTime")) {
                    result.start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Timestamp")) {
                    result.timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ValidationFailureMode")) {
                    result.validation_failure_mode = std.meta.stringToEnum(HookFailureMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ValidationName")) {
                    result.validation_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ValidationPath")) {
                    result.validation_path = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ValidationStatus")) {
                    result.validation_status = std.meta.stringToEnum(ValidationStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ValidationStatusReason")) {
                    result.validation_status_reason = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeOutput(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Output {
    var result: Output = undefined;
    result.description = null;
    result.export_name = null;
    result.output_key = null;
    result.output_value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExportName")) {
                    result.export_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OutputKey")) {
                    result.output_key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OutputValue")) {
                    result.output_value = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeParameter(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Parameter {
    var result: Parameter = undefined;
    result.parameter_key = null;
    result.parameter_value = null;
    result.resolved_value = null;
    result.use_previous_value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ParameterKey")) {
                    result.parameter_key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ParameterValue")) {
                    result.parameter_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResolvedValue")) {
                    result.resolved_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UsePreviousValue")) {
                    result.use_previous_value = std.mem.eql(u8, try reader.readElementText(), "true");
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

pub fn deserializeParameterConstraints(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ParameterConstraints {
    var result: ParameterConstraints = undefined;
    result.allowed_values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowedValues")) {
                    result.allowed_values = try deserializeAllowedValues(allocator, reader, "member");
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

pub fn deserializeParameterDeclaration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ParameterDeclaration {
    var result: ParameterDeclaration = undefined;
    result.default_value = null;
    result.description = null;
    result.no_echo = null;
    result.parameter_constraints = null;
    result.parameter_key = null;
    result.parameter_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NoEcho")) {
                    result.no_echo = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ParameterConstraints")) {
                    result.parameter_constraints = try deserializeParameterConstraints(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ParameterKey")) {
                    result.parameter_key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ParameterType")) {
                    result.parameter_type = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializePhysicalResourceIdContextKeyValuePair(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PhysicalResourceIdContextKeyValuePair {
    var result: PhysicalResourceIdContextKeyValuePair = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializePropertyDifference(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PropertyDifference {
    var result: PropertyDifference = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActualValue")) {
                    result.actual_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DifferenceType")) {
                    result.difference_type = std.meta.stringToEnum(DifferenceType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExpectedValue")) {
                    result.expected_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PropertyPath")) {
                    result.property_path = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeRequiredActivatedType(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RequiredActivatedType {
    var result: RequiredActivatedType = undefined;
    result.original_type_name = null;
    result.publisher_id = null;
    result.supported_major_versions = null;
    result.type_name_alias = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OriginalTypeName")) {
                    result.original_type_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublisherId")) {
                    result.publisher_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportedMajorVersions")) {
                    result.supported_major_versions = try deserializeSupportedMajorVersions(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "TypeNameAlias")) {
                    result.type_name_alias = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeResourceChange(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResourceChange {
    var result: ResourceChange = undefined;
    result.action = null;
    result.after_context = null;
    result.before_context = null;
    result.change_set_id = null;
    result.details = null;
    result.logical_resource_id = null;
    result.module_info = null;
    result.physical_resource_id = null;
    result.policy_action = null;
    result.previous_deployment_context = null;
    result.replacement = null;
    result.resource_drift_ignored_attributes = null;
    result.resource_drift_status = null;
    result.resource_type = null;
    result.scope = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Action")) {
                    result.action = std.meta.stringToEnum(ChangeAction, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AfterContext")) {
                    result.after_context = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BeforeContext")) {
                    result.before_context = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChangeSetId")) {
                    result.change_set_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Details")) {
                    result.details = try deserializeResourceChangeDetails(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "LogicalResourceId")) {
                    result.logical_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ModuleInfo")) {
                    result.module_info = try deserializeModuleInfo(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PhysicalResourceId")) {
                    result.physical_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyAction")) {
                    result.policy_action = std.meta.stringToEnum(PolicyAction, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreviousDeploymentContext")) {
                    result.previous_deployment_context = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Replacement")) {
                    result.replacement = std.meta.stringToEnum(Replacement, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceDriftIgnoredAttributes")) {
                    result.resource_drift_ignored_attributes = try deserializeResourceDriftIgnoredAttributes(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ResourceDriftStatus")) {
                    result.resource_drift_status = std.meta.stringToEnum(StackResourceDriftStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Scope")) {
                    result.scope = try deserializeScope(allocator, reader, "member");
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

pub fn deserializeResourceChangeDetail(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResourceChangeDetail {
    var result: ResourceChangeDetail = undefined;
    result.causing_entity = null;
    result.change_source = null;
    result.evaluation = null;
    result.target = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CausingEntity")) {
                    result.causing_entity = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChangeSource")) {
                    result.change_source = std.meta.stringToEnum(ChangeSource, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Evaluation")) {
                    result.evaluation = std.meta.stringToEnum(EvaluationType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Target")) {
                    result.target = try deserializeResourceTargetDefinition(allocator, reader);
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

pub fn deserializeResourceDetail(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResourceDetail {
    var result: ResourceDetail = undefined;
    result.logical_resource_id = null;
    result.resource_identifier = null;
    result.resource_status = null;
    result.resource_status_reason = null;
    result.resource_type = null;
    result.warnings = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LogicalResourceId")) {
                    result.logical_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceIdentifier")) {
                    result.resource_identifier = try deserializeResourceIdentifierProperties(allocator, reader, "entry");
                } else if (std.mem.eql(u8, e.local, "ResourceStatus")) {
                    result.resource_status = std.meta.stringToEnum(GeneratedTemplateResourceStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceStatusReason")) {
                    result.resource_status_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Warnings")) {
                    result.warnings = try deserializeWarningDetails(allocator, reader, "member");
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

pub fn deserializeResourceDriftIgnoredAttribute(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResourceDriftIgnoredAttribute {
    var result: ResourceDriftIgnoredAttribute = undefined;
    result.path = null;
    result.reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Reason")) {
                    result.reason = std.meta.stringToEnum(DriftIgnoredReason, try reader.readElementText());
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

pub fn deserializeResourceIdentifierSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResourceIdentifierSummary {
    var result: ResourceIdentifierSummary = undefined;
    result.logical_resource_ids = null;
    result.resource_identifiers = null;
    result.resource_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LogicalResourceIds")) {
                    result.logical_resource_ids = try deserializeLogicalResourceIds(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ResourceIdentifiers")) {
                    result.resource_identifiers = try deserializeResourceIdentifiers(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeResourceLocation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResourceLocation {
    var result: ResourceLocation = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LogicalResourceId")) {
                    result.logical_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackName")) {
                    result.stack_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeResourceMapping(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResourceMapping {
    var result: ResourceMapping = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Destination")) {
                    result.destination = try deserializeResourceLocation(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Source")) {
                    result.source = try deserializeResourceLocation(allocator, reader);
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

pub fn deserializeResourceScanSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResourceScanSummary {
    var result: ResourceScanSummary = undefined;
    result.end_time = null;
    result.percentage_completed = null;
    result.resource_scan_id = null;
    result.scan_type = null;
    result.start_time = null;
    result.status = null;
    result.status_reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EndTime")) {
                    result.end_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "PercentageCompleted")) {
                    result.percentage_completed = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ResourceScanId")) {
                    result.resource_scan_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ScanType")) {
                    result.scan_type = std.meta.stringToEnum(ScanType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StartTime")) {
                    result.start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(ResourceScanStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeResourceTargetDefinition(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResourceTargetDefinition {
    var result: ResourceTargetDefinition = undefined;
    result.after_value = null;
    result.after_value_from = null;
    result.attribute = null;
    result.attribute_change_type = null;
    result.before_value = null;
    result.before_value_from = null;
    result.drift = null;
    result.name = null;
    result.path = null;
    result.requires_recreation = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AfterValue")) {
                    result.after_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AfterValueFrom")) {
                    result.after_value_from = std.meta.stringToEnum(AfterValueFrom, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Attribute")) {
                    result.attribute = std.meta.stringToEnum(ResourceAttribute, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AttributeChangeType")) {
                    result.attribute_change_type = std.meta.stringToEnum(AttributeChangeType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BeforeValue")) {
                    result.before_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BeforeValueFrom")) {
                    result.before_value_from = std.meta.stringToEnum(BeforeValueFrom, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Drift")) {
                    result.drift = try deserializeLiveResourceDrift(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RequiresRecreation")) {
                    result.requires_recreation = std.meta.stringToEnum(RequiresRecreation, try reader.readElementText());
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

pub fn deserializeRollbackConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RollbackConfiguration {
    var result: RollbackConfiguration = undefined;
    result.monitoring_time_in_minutes = null;
    result.rollback_triggers = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MonitoringTimeInMinutes")) {
                    result.monitoring_time_in_minutes = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "RollbackTriggers")) {
                    result.rollback_triggers = try deserializeRollbackTriggers(allocator, reader, "member");
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

pub fn deserializeRollbackTrigger(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RollbackTrigger {
    var result: RollbackTrigger = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeScanFilter(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ScanFilter {
    var result: ScanFilter = undefined;
    result.types = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Types")) {
                    result.types = try deserializeResourceTypeFilters(allocator, reader, "member");
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

pub fn deserializeScannedResource(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ScannedResource {
    var result: ScannedResource = undefined;
    result.managed_by_stack = null;
    result.resource_identifier = null;
    result.resource_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ManagedByStack")) {
                    result.managed_by_stack = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ResourceIdentifier")) {
                    result.resource_identifier = try deserializeJazzResourceIdentifierProperties(allocator, reader, "entry");
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeStack(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Stack {
    var result: Stack = undefined;
    result.capabilities = null;
    result.change_set_id = null;
    result.deletion_mode = null;
    result.deletion_time = null;
    result.description = null;
    result.detailed_status = null;
    result.disable_rollback = null;
    result.drift_information = null;
    result.enable_termination_protection = null;
    result.last_operations = null;
    result.last_updated_time = null;
    result.notification_ar_ns = null;
    result.outputs = null;
    result.parameters = null;
    result.parent_id = null;
    result.retain_except_on_create = null;
    result.role_arn = null;
    result.rollback_configuration = null;
    result.root_id = null;
    result.stack_id = null;
    result.stack_status_reason = null;
    result.tags = null;
    result.timeout_in_minutes = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Capabilities")) {
                    result.capabilities = try deserializeCapabilities(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ChangeSetId")) {
                    result.change_set_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreationTime")) {
                    result.creation_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DeletionMode")) {
                    result.deletion_mode = std.meta.stringToEnum(DeletionMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DeletionTime")) {
                    result.deletion_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DetailedStatus")) {
                    result.detailed_status = std.meta.stringToEnum(DetailedStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DisableRollback")) {
                    result.disable_rollback = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DriftInformation")) {
                    result.drift_information = try deserializeStackDriftInformation(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "EnableTerminationProtection")) {
                    result.enable_termination_protection = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "LastOperations")) {
                    result.last_operations = try deserializeLastOperations(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "LastUpdatedTime")) {
                    result.last_updated_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NotificationARNs")) {
                    result.notification_ar_ns = try deserializeNotificationARNs(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Outputs")) {
                    result.outputs = try deserializeOutputs(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Parameters")) {
                    result.parameters = try deserializeParameters(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ParentId")) {
                    result.parent_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RetainExceptOnCreate")) {
                    result.retain_except_on_create = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "RoleARN")) {
                    result.role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RollbackConfiguration")) {
                    result.rollback_configuration = try deserializeRollbackConfiguration(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "RootId")) {
                    result.root_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackName")) {
                    result.stack_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackStatus")) {
                    result.stack_status = std.meta.stringToEnum(StackStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackStatusReason")) {
                    result.stack_status_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTags(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "TimeoutInMinutes")) {
                    result.timeout_in_minutes = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

pub fn deserializeStackDriftInformation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackDriftInformation {
    _ = allocator;
    var result: StackDriftInformation = undefined;
    result.last_check_timestamp = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LastCheckTimestamp")) {
                    result.last_check_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "StackDriftStatus")) {
                    result.stack_drift_status = std.meta.stringToEnum(StackDriftStatus, try reader.readElementText());
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

pub fn deserializeStackDriftInformationSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackDriftInformationSummary {
    _ = allocator;
    var result: StackDriftInformationSummary = undefined;
    result.last_check_timestamp = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LastCheckTimestamp")) {
                    result.last_check_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "StackDriftStatus")) {
                    result.stack_drift_status = std.meta.stringToEnum(StackDriftStatus, try reader.readElementText());
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

pub fn deserializeStackEvent(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackEvent {
    var result: StackEvent = undefined;
    result.client_request_token = null;
    result.detailed_status = null;
    result.hook_failure_mode = null;
    result.hook_invocation_id = null;
    result.hook_invocation_point = null;
    result.hook_status = null;
    result.hook_status_reason = null;
    result.hook_type = null;
    result.logical_resource_id = null;
    result.operation_id = null;
    result.physical_resource_id = null;
    result.resource_properties = null;
    result.resource_status = null;
    result.resource_status_reason = null;
    result.resource_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ClientRequestToken")) {
                    result.client_request_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DetailedStatus")) {
                    result.detailed_status = std.meta.stringToEnum(DetailedStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EventId")) {
                    result.event_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookFailureMode")) {
                    result.hook_failure_mode = std.meta.stringToEnum(HookFailureMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookInvocationId")) {
                    result.hook_invocation_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookInvocationPoint")) {
                    result.hook_invocation_point = std.meta.stringToEnum(HookInvocationPoint, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookStatus")) {
                    result.hook_status = std.meta.stringToEnum(HookStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookStatusReason")) {
                    result.hook_status_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookType")) {
                    result.hook_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogicalResourceId")) {
                    result.logical_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperationId")) {
                    result.operation_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PhysicalResourceId")) {
                    result.physical_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceProperties")) {
                    result.resource_properties = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceStatus")) {
                    result.resource_status = std.meta.stringToEnum(ResourceStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceStatusReason")) {
                    result.resource_status_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackName")) {
                    result.stack_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackInstance(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackInstance {
    var result: StackInstance = undefined;
    result.account = null;
    result.drift_status = null;
    result.last_drift_check_timestamp = null;
    result.last_operation_id = null;
    result.organizational_unit_id = null;
    result.parameter_overrides = null;
    result.region = null;
    result.stack_id = null;
    result.stack_instance_status = null;
    result.stack_set_id = null;
    result.status = null;
    result.status_reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Account")) {
                    result.account = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DriftStatus")) {
                    result.drift_status = std.meta.stringToEnum(StackDriftStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastDriftCheckTimestamp")) {
                    result.last_drift_check_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "LastOperationId")) {
                    result.last_operation_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OrganizationalUnitId")) {
                    result.organizational_unit_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ParameterOverrides")) {
                    result.parameter_overrides = try deserializeParameters(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackInstanceStatus")) {
                    result.stack_instance_status = try deserializeStackInstanceComprehensiveStatus(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "StackSetId")) {
                    result.stack_set_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(StackInstanceStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackInstanceComprehensiveStatus(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackInstanceComprehensiveStatus {
    _ = allocator;
    var result: StackInstanceComprehensiveStatus = undefined;
    result.detailed_status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DetailedStatus")) {
                    result.detailed_status = std.meta.stringToEnum(StackInstanceDetailedStatus, try reader.readElementText());
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

pub fn deserializeStackInstanceResourceDriftsSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackInstanceResourceDriftsSummary {
    var result: StackInstanceResourceDriftsSummary = undefined;
    result.physical_resource_id = null;
    result.physical_resource_id_context = null;
    result.property_differences = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LogicalResourceId")) {
                    result.logical_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PhysicalResourceId")) {
                    result.physical_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PhysicalResourceIdContext")) {
                    result.physical_resource_id_context = try deserializePhysicalResourceIdContext(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "PropertyDifferences")) {
                    result.property_differences = try deserializePropertyDifferences(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackResourceDriftStatus")) {
                    result.stack_resource_drift_status = std.meta.stringToEnum(StackResourceDriftStatus, try reader.readElementText());
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

pub fn deserializeStackInstanceSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackInstanceSummary {
    var result: StackInstanceSummary = undefined;
    result.account = null;
    result.drift_status = null;
    result.last_drift_check_timestamp = null;
    result.last_operation_id = null;
    result.organizational_unit_id = null;
    result.region = null;
    result.stack_id = null;
    result.stack_instance_status = null;
    result.stack_set_id = null;
    result.status = null;
    result.status_reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Account")) {
                    result.account = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DriftStatus")) {
                    result.drift_status = std.meta.stringToEnum(StackDriftStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastDriftCheckTimestamp")) {
                    result.last_drift_check_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "LastOperationId")) {
                    result.last_operation_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OrganizationalUnitId")) {
                    result.organizational_unit_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackInstanceStatus")) {
                    result.stack_instance_status = try deserializeStackInstanceComprehensiveStatus(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "StackSetId")) {
                    result.stack_set_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(StackInstanceStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackRefactorAction(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackRefactorAction {
    var result: StackRefactorAction = undefined;
    result.action = null;
    result.description = null;
    result.detection = null;
    result.detection_reason = null;
    result.entity = null;
    result.physical_resource_id = null;
    result.resource_identifier = null;
    result.resource_mapping = null;
    result.tag_resources = null;
    result.untag_resources = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Action")) {
                    result.action = std.meta.stringToEnum(StackRefactorActionType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Detection")) {
                    result.detection = std.meta.stringToEnum(StackRefactorDetection, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DetectionReason")) {
                    result.detection_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Entity")) {
                    result.entity = std.meta.stringToEnum(StackRefactorActionEntity, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PhysicalResourceId")) {
                    result.physical_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceIdentifier")) {
                    result.resource_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceMapping")) {
                    result.resource_mapping = try deserializeResourceMapping(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "TagResources")) {
                    result.tag_resources = try deserializeStackRefactorTagResources(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "UntagResources")) {
                    result.untag_resources = try deserializeStackRefactorUntagResources(allocator, reader, "member");
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

pub fn deserializeStackRefactorSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackRefactorSummary {
    var result: StackRefactorSummary = undefined;
    result.description = null;
    result.execution_status = null;
    result.execution_status_reason = null;
    result.stack_refactor_id = null;
    result.status = null;
    result.status_reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExecutionStatus")) {
                    result.execution_status = std.meta.stringToEnum(StackRefactorExecutionStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExecutionStatusReason")) {
                    result.execution_status_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackRefactorId")) {
                    result.stack_refactor_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(StackRefactorStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackResource(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackResource {
    var result: StackResource = undefined;
    result.description = null;
    result.drift_information = null;
    result.module_info = null;
    result.physical_resource_id = null;
    result.resource_status_reason = null;
    result.stack_id = null;
    result.stack_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DriftInformation")) {
                    result.drift_information = try deserializeStackResourceDriftInformation(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "LogicalResourceId")) {
                    result.logical_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ModuleInfo")) {
                    result.module_info = try deserializeModuleInfo(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PhysicalResourceId")) {
                    result.physical_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceStatus")) {
                    result.resource_status = std.meta.stringToEnum(ResourceStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceStatusReason")) {
                    result.resource_status_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackName")) {
                    result.stack_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackResourceDetail(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackResourceDetail {
    var result: StackResourceDetail = undefined;
    result.description = null;
    result.drift_information = null;
    result.metadata = null;
    result.module_info = null;
    result.physical_resource_id = null;
    result.resource_status_reason = null;
    result.stack_id = null;
    result.stack_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DriftInformation")) {
                    result.drift_information = try deserializeStackResourceDriftInformation(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "LastUpdatedTimestamp")) {
                    result.last_updated_timestamp = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogicalResourceId")) {
                    result.logical_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Metadata")) {
                    result.metadata = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ModuleInfo")) {
                    result.module_info = try deserializeModuleInfo(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PhysicalResourceId")) {
                    result.physical_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceStatus")) {
                    result.resource_status = std.meta.stringToEnum(ResourceStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceStatusReason")) {
                    result.resource_status_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackName")) {
                    result.stack_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackResourceDrift(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackResourceDrift {
    var result: StackResourceDrift = undefined;
    result.actual_properties = null;
    result.drift_status_reason = null;
    result.expected_properties = null;
    result.module_info = null;
    result.physical_resource_id = null;
    result.physical_resource_id_context = null;
    result.property_differences = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActualProperties")) {
                    result.actual_properties = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DriftStatusReason")) {
                    result.drift_status_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExpectedProperties")) {
                    result.expected_properties = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogicalResourceId")) {
                    result.logical_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ModuleInfo")) {
                    result.module_info = try deserializeModuleInfo(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PhysicalResourceId")) {
                    result.physical_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PhysicalResourceIdContext")) {
                    result.physical_resource_id_context = try deserializePhysicalResourceIdContext(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "PropertyDifferences")) {
                    result.property_differences = try deserializePropertyDifferences(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackResourceDriftStatus")) {
                    result.stack_resource_drift_status = std.meta.stringToEnum(StackResourceDriftStatus, try reader.readElementText());
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

pub fn deserializeStackResourceDriftInformation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackResourceDriftInformation {
    _ = allocator;
    var result: StackResourceDriftInformation = undefined;
    result.last_check_timestamp = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LastCheckTimestamp")) {
                    result.last_check_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "StackResourceDriftStatus")) {
                    result.stack_resource_drift_status = std.meta.stringToEnum(StackResourceDriftStatus, try reader.readElementText());
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

pub fn deserializeStackResourceDriftInformationSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackResourceDriftInformationSummary {
    _ = allocator;
    var result: StackResourceDriftInformationSummary = undefined;
    result.last_check_timestamp = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LastCheckTimestamp")) {
                    result.last_check_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "StackResourceDriftStatus")) {
                    result.stack_resource_drift_status = std.meta.stringToEnum(StackResourceDriftStatus, try reader.readElementText());
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

pub fn deserializeStackResourceSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackResourceSummary {
    var result: StackResourceSummary = undefined;
    result.drift_information = null;
    result.module_info = null;
    result.physical_resource_id = null;
    result.resource_status_reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DriftInformation")) {
                    result.drift_information = try deserializeStackResourceDriftInformationSummary(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "LastUpdatedTimestamp")) {
                    result.last_updated_timestamp = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogicalResourceId")) {
                    result.logical_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ModuleInfo")) {
                    result.module_info = try deserializeModuleInfo(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PhysicalResourceId")) {
                    result.physical_resource_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceStatus")) {
                    result.resource_status = std.meta.stringToEnum(ResourceStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceStatusReason")) {
                    result.resource_status_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackSet(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackSet {
    var result: StackSet = undefined;
    result.administration_role_arn = null;
    result.auto_deployment = null;
    result.capabilities = null;
    result.description = null;
    result.execution_role_name = null;
    result.managed_execution = null;
    result.organizational_unit_ids = null;
    result.parameters = null;
    result.permission_model = null;
    result.regions = null;
    result.stack_set_arn = null;
    result.stack_set_drift_detection_details = null;
    result.stack_set_id = null;
    result.stack_set_name = null;
    result.status = null;
    result.tags = null;
    result.template_body = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AdministrationRoleARN")) {
                    result.administration_role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutoDeployment")) {
                    result.auto_deployment = try deserializeAutoDeployment(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Capabilities")) {
                    result.capabilities = try deserializeCapabilities(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExecutionRoleName")) {
                    result.execution_role_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ManagedExecution")) {
                    result.managed_execution = try deserializeManagedExecution(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "OrganizationalUnitIds")) {
                    result.organizational_unit_ids = try deserializeOrganizationalUnitIdList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Parameters")) {
                    result.parameters = try deserializeParameters(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "PermissionModel")) {
                    result.permission_model = std.meta.stringToEnum(PermissionModels, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Regions")) {
                    result.regions = try deserializeRegionList(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "StackSetARN")) {
                    result.stack_set_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackSetDriftDetectionDetails")) {
                    result.stack_set_drift_detection_details = try deserializeStackSetDriftDetectionDetails(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "StackSetId")) {
                    result.stack_set_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackSetName")) {
                    result.stack_set_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(StackSetStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTags(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "TemplateBody")) {
                    result.template_body = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackSetAutoDeploymentTargetSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackSetAutoDeploymentTargetSummary {
    var result: StackSetAutoDeploymentTargetSummary = undefined;
    result.organizational_unit_id = null;
    result.regions = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OrganizationalUnitId")) {
                    result.organizational_unit_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Regions")) {
                    result.regions = try deserializeRegionList(allocator, reader, "member");
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

pub fn deserializeStackSetDriftDetectionDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackSetDriftDetectionDetails {
    _ = allocator;
    var result: StackSetDriftDetectionDetails = undefined;
    result.drift_detection_status = null;
    result.drifted_stack_instances_count = null;
    result.drift_status = null;
    result.failed_stack_instances_count = null;
    result.in_progress_stack_instances_count = null;
    result.in_sync_stack_instances_count = null;
    result.last_drift_check_timestamp = null;
    result.total_stack_instances_count = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DriftDetectionStatus")) {
                    result.drift_detection_status = std.meta.stringToEnum(StackSetDriftDetectionStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DriftedStackInstancesCount")) {
                    result.drifted_stack_instances_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "DriftStatus")) {
                    result.drift_status = std.meta.stringToEnum(StackSetDriftStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FailedStackInstancesCount")) {
                    result.failed_stack_instances_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "InProgressStackInstancesCount")) {
                    result.in_progress_stack_instances_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "InSyncStackInstancesCount")) {
                    result.in_sync_stack_instances_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "LastDriftCheckTimestamp")) {
                    result.last_drift_check_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "TotalStackInstancesCount")) {
                    result.total_stack_instances_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

pub fn deserializeStackSetOperation(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackSetOperation {
    var result: StackSetOperation = undefined;
    result.action = null;
    result.administration_role_arn = null;
    result.creation_timestamp = null;
    result.deployment_targets = null;
    result.end_timestamp = null;
    result.execution_role_name = null;
    result.operation_id = null;
    result.operation_preferences = null;
    result.retain_stacks = null;
    result.stack_set_drift_detection_details = null;
    result.stack_set_id = null;
    result.status = null;
    result.status_details = null;
    result.status_reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Action")) {
                    result.action = std.meta.stringToEnum(StackSetOperationAction, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AdministrationRoleARN")) {
                    result.administration_role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreationTimestamp")) {
                    result.creation_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DeploymentTargets")) {
                    result.deployment_targets = try deserializeDeploymentTargets(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "EndTimestamp")) {
                    result.end_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ExecutionRoleName")) {
                    result.execution_role_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperationId")) {
                    result.operation_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperationPreferences")) {
                    result.operation_preferences = try deserializeStackSetOperationPreferences(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "RetainStacks")) {
                    result.retain_stacks = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "StackSetDriftDetectionDetails")) {
                    result.stack_set_drift_detection_details = try deserializeStackSetDriftDetectionDetails(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "StackSetId")) {
                    result.stack_set_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(StackSetOperationStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusDetails")) {
                    result.status_details = try deserializeStackSetOperationStatusDetails(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackSetOperationPreferences(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackSetOperationPreferences {
    var result: StackSetOperationPreferences = undefined;
    result.concurrency_mode = null;
    result.failure_tolerance_count = null;
    result.failure_tolerance_percentage = null;
    result.max_concurrent_count = null;
    result.max_concurrent_percentage = null;
    result.region_concurrency_type = null;
    result.region_order = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ConcurrencyMode")) {
                    result.concurrency_mode = std.meta.stringToEnum(ConcurrencyMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "FailureToleranceCount")) {
                    result.failure_tolerance_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "FailureTolerancePercentage")) {
                    result.failure_tolerance_percentage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxConcurrentCount")) {
                    result.max_concurrent_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MaxConcurrentPercentage")) {
                    result.max_concurrent_percentage = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "RegionConcurrencyType")) {
                    result.region_concurrency_type = std.meta.stringToEnum(RegionConcurrencyType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RegionOrder")) {
                    result.region_order = try deserializeRegionList(allocator, reader, "member");
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

pub fn deserializeStackSetOperationResultSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackSetOperationResultSummary {
    var result: StackSetOperationResultSummary = undefined;
    result.account = null;
    result.account_gate_result = null;
    result.organizational_unit_id = null;
    result.region = null;
    result.status = null;
    result.status_reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Account")) {
                    result.account = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AccountGateResult")) {
                    result.account_gate_result = try deserializeAccountGateResult(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "OrganizationalUnitId")) {
                    result.organizational_unit_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(StackSetOperationResultStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackSetOperationStatusDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackSetOperationStatusDetails {
    _ = allocator;
    var result: StackSetOperationStatusDetails = undefined;
    result.failed_stack_instances_count = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "FailedStackInstancesCount")) {
                    result.failed_stack_instances_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

pub fn deserializeStackSetOperationSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackSetOperationSummary {
    var result: StackSetOperationSummary = undefined;
    result.action = null;
    result.creation_timestamp = null;
    result.end_timestamp = null;
    result.operation_id = null;
    result.operation_preferences = null;
    result.status = null;
    result.status_details = null;
    result.status_reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Action")) {
                    result.action = std.meta.stringToEnum(StackSetOperationAction, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreationTimestamp")) {
                    result.creation_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "EndTimestamp")) {
                    result.end_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "OperationId")) {
                    result.operation_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperationPreferences")) {
                    result.operation_preferences = try deserializeStackSetOperationPreferences(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(StackSetOperationStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusDetails")) {
                    result.status_details = try deserializeStackSetOperationStatusDetails(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackSetSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackSetSummary {
    var result: StackSetSummary = undefined;
    result.auto_deployment = null;
    result.description = null;
    result.drift_status = null;
    result.last_drift_check_timestamp = null;
    result.managed_execution = null;
    result.permission_model = null;
    result.stack_set_id = null;
    result.stack_set_name = null;
    result.status = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AutoDeployment")) {
                    result.auto_deployment = try deserializeAutoDeployment(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DriftStatus")) {
                    result.drift_status = std.meta.stringToEnum(StackDriftStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastDriftCheckTimestamp")) {
                    result.last_drift_check_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ManagedExecution")) {
                    result.managed_execution = try deserializeManagedExecution(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PermissionModel")) {
                    result.permission_model = std.meta.stringToEnum(PermissionModels, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackSetId")) {
                    result.stack_set_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackSetName")) {
                    result.stack_set_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(StackSetStatus, try reader.readElementText());
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

pub fn deserializeStackSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !StackSummary {
    var result: StackSummary = undefined;
    result.deletion_time = null;
    result.drift_information = null;
    result.last_operations = null;
    result.last_updated_time = null;
    result.parent_id = null;
    result.root_id = null;
    result.stack_id = null;
    result.stack_status_reason = null;
    result.template_description = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreationTime")) {
                    result.creation_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DeletionTime")) {
                    result.deletion_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DriftInformation")) {
                    result.drift_information = try deserializeStackDriftInformationSummary(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "LastOperations")) {
                    result.last_operations = try deserializeLastOperations(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "LastUpdatedTime")) {
                    result.last_updated_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ParentId")) {
                    result.parent_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RootId")) {
                    result.root_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackName")) {
                    result.stack_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackStatus")) {
                    result.stack_status = std.meta.stringToEnum(StackStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackStatusReason")) {
                    result.stack_status_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TemplateDescription")) {
                    result.template_description = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeTag(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Tag {
    var result: Tag = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeTemplateConfiguration(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TemplateConfiguration {
    _ = allocator;
    var result: TemplateConfiguration = undefined;
    result.deletion_policy = null;
    result.update_replace_policy = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeletionPolicy")) {
                    result.deletion_policy = std.meta.stringToEnum(GeneratedTemplateDeletionPolicy, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UpdateReplacePolicy")) {
                    result.update_replace_policy = std.meta.stringToEnum(GeneratedTemplateUpdateReplacePolicy, try reader.readElementText());
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

pub fn deserializeTemplateParameter(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TemplateParameter {
    var result: TemplateParameter = undefined;
    result.default_value = null;
    result.description = null;
    result.no_echo = null;
    result.parameter_key = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NoEcho")) {
                    result.no_echo = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ParameterKey")) {
                    result.parameter_key = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeTemplateProgress(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TemplateProgress {
    _ = allocator;
    var result: TemplateProgress = undefined;
    result.resources_failed = null;
    result.resources_pending = null;
    result.resources_processing = null;
    result.resources_succeeded = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ResourcesFailed")) {
                    result.resources_failed = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ResourcesPending")) {
                    result.resources_pending = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ResourcesProcessing")) {
                    result.resources_processing = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ResourcesSucceeded")) {
                    result.resources_succeeded = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
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

pub fn deserializeTemplateSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TemplateSummary {
    var result: TemplateSummary = undefined;
    result.creation_time = null;
    result.generated_template_id = null;
    result.generated_template_name = null;
    result.last_updated_time = null;
    result.number_of_resources = null;
    result.status = null;
    result.status_reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreationTime")) {
                    result.creation_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "GeneratedTemplateId")) {
                    result.generated_template_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GeneratedTemplateName")) {
                    result.generated_template_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastUpdatedTime")) {
                    result.last_updated_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NumberOfResources")) {
                    result.number_of_resources = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(GeneratedTemplateStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeTypeConfigurationDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TypeConfigurationDetails {
    var result: TypeConfigurationDetails = undefined;
    result.alias = null;
    result.arn = null;
    result.configuration = null;
    result.is_default_configuration = null;
    result.last_updated = null;
    result.type_arn = null;
    result.type_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Alias")) {
                    result.alias = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Configuration")) {
                    result.configuration = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsDefaultConfiguration")) {
                    result.is_default_configuration = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "LastUpdated")) {
                    result.last_updated = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "TypeArn")) {
                    result.type_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeName")) {
                    result.type_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeTypeConfigurationIdentifier(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TypeConfigurationIdentifier {
    var result: TypeConfigurationIdentifier = undefined;
    result.@"type" = null;
    result.type_arn = null;
    result.type_configuration_alias = null;
    result.type_configuration_arn = null;
    result.type_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(ThirdPartyType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeArn")) {
                    result.type_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeConfigurationAlias")) {
                    result.type_configuration_alias = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeConfigurationArn")) {
                    result.type_configuration_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeName")) {
                    result.type_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeTypeSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TypeSummary {
    var result: TypeSummary = undefined;
    result.default_version_id = null;
    result.description = null;
    result.is_activated = null;
    result.last_updated = null;
    result.latest_public_version = null;
    result.original_type_name = null;
    result.public_version_number = null;
    result.publisher_id = null;
    result.publisher_identity = null;
    result.publisher_name = null;
    result.@"type" = null;
    result.type_arn = null;
    result.type_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DefaultVersionId")) {
                    result.default_version_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsActivated")) {
                    result.is_activated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "LastUpdated")) {
                    result.last_updated = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "LatestPublicVersion")) {
                    result.latest_public_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginalTypeName")) {
                    result.original_type_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublicVersionNumber")) {
                    result.public_version_number = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublisherId")) {
                    result.publisher_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublisherIdentity")) {
                    result.publisher_identity = std.meta.stringToEnum(IdentityProvider, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublisherName")) {
                    result.publisher_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(RegistryType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeArn")) {
                    result.type_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeName")) {
                    result.type_name = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeTypeVersionSummary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TypeVersionSummary {
    var result: TypeVersionSummary = undefined;
    result.arn = null;
    result.description = null;
    result.is_default_version = null;
    result.public_version_number = null;
    result.time_created = null;
    result.@"type" = null;
    result.type_name = null;
    result.version_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsDefaultVersion")) {
                    result.is_default_version = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "PublicVersionNumber")) {
                    result.public_version_number = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TimeCreated")) {
                    result.time_created = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(RegistryType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeName")) {
                    result.type_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VersionId")) {
                    result.version_id = try allocator.dupe(u8, try reader.readElementText());
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

pub fn deserializeWarningDetail(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !WarningDetail {
    var result: WarningDetail = undefined;
    result.properties = null;
    result.@"type" = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Properties")) {
                    result.properties = try deserializeWarningProperties(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(WarningType, try reader.readElementText());
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

pub fn deserializeWarningProperty(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !WarningProperty {
    var result: WarningProperty = undefined;
    result.description = null;
    result.property_path = null;
    result.required = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PropertyPath")) {
                    result.property_path = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Required")) {
                    result.required = std.mem.eql(u8, try reader.readElementText(), "true");
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

pub fn deserializeWarnings(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Warnings {
    var result: Warnings = undefined;
    result.unrecognized_resource_types = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "UnrecognizedResourceTypes")) {
                    result.unrecognized_resource_types = try deserializeResourceTypes(allocator, reader, "member");
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

pub fn serializeAccountList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeCapabilities(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Capability, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, @tagName(item));
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeJazzLogicalResourceIds(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeLogicalResourceIds(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeNotificationARNs(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeOperationResultFilters(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const OperationResultFilter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeOperationResultFilter(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeOrganizationalUnitIdList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeParameters(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Parameter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeParameter(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeRegionList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeResourceDefinitions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ResourceDefinition, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeResourceDefinition(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeResourceMappings(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ResourceMapping, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeResourceMapping(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeResourceTypeFilters(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeResourceTypes(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeResourcesToImport(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ResourceToImport, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeResourceToImport(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeResourcesToSkip(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeRetainResources(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeRollbackTriggers(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const RollbackTrigger, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeRollbackTrigger(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeScanFilters(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ScanFilter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeScanFilter(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeScannedResourceIdentifiers(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ScannedResourceIdentifier, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeScannedResourceIdentifier(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeStackDefinitions(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const StackDefinition, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeStackDefinition(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeStackIdList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeStackInstanceFilters(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const StackInstanceFilter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeStackInstanceFilter(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeStackRefactorExecutionStatusFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const StackRefactorExecutionStatus, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, @tagName(item));
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeStackResourceDriftStatusFilters(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const StackResourceDriftStatus, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, @tagName(item));
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeStackSetARNList(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeStackStatusFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const StackStatus, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, @tagName(item));
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeTags(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Tag, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeTag(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeTypeConfigurationIdentifiers(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const TypeConfigurationIdentifier, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeTypeConfigurationIdentifier(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeJazzResourceIdentifierProperties(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.StringMapEntry, comptime entry_tag: []const u8) !void {
    for (entries) |entry| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, entry_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, "<key>");
        try aws.xml.appendXmlEscaped(allocator, buf, entry.key);
        try buf.appendSlice(allocator, "</key>");
        try buf.appendSlice(allocator, "<value>");
        try aws.xml.appendXmlEscaped(allocator, buf, entry.value);
        try buf.appendSlice(allocator, "</value>");
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, entry_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeResourceIdentifierProperties(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.StringMapEntry, comptime entry_tag: []const u8) !void {
    for (entries) |entry| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, entry_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, "<key>");
        try aws.xml.appendXmlEscaped(allocator, buf, entry.key);
        try buf.appendSlice(allocator, "</key>");
        try buf.appendSlice(allocator, "<value>");
        try aws.xml.appendXmlEscaped(allocator, buf, entry.value);
        try buf.appendSlice(allocator, "</value>");
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, entry_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeAutoDeployment(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: AutoDeployment) !void {
    if (value.depends_on) |v| {
        try buf.appendSlice(allocator, "<DependsOn>");
        try serializeStackSetARNList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</DependsOn>");
    }
    if (value.enabled) |v| {
        try buf.appendSlice(allocator, "<Enabled>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</Enabled>");
    }
    if (value.retain_stacks_on_account_removal) |v| {
        try buf.appendSlice(allocator, "<RetainStacksOnAccountRemoval>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</RetainStacksOnAccountRemoval>");
    }
}

pub fn serializeDeploymentTargets(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DeploymentTargets) !void {
    if (value.account_filter_type) |v| {
        try buf.appendSlice(allocator, "<AccountFilterType>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</AccountFilterType>");
    }
    if (value.accounts) |v| {
        try buf.appendSlice(allocator, "<Accounts>");
        try serializeAccountList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Accounts>");
    }
    if (value.accounts_url) |v| {
        try buf.appendSlice(allocator, "<AccountsUrl>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</AccountsUrl>");
    }
    if (value.organizational_unit_ids) |v| {
        try buf.appendSlice(allocator, "<OrganizationalUnitIds>");
        try serializeOrganizationalUnitIdList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</OrganizationalUnitIds>");
    }
}

pub fn serializeEventFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: EventFilter) !void {
    if (value.failed_events) |v| {
        try buf.appendSlice(allocator, "<FailedEvents>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</FailedEvents>");
    }
}

pub fn serializeLoggingConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: LoggingConfig) !void {
    try buf.appendSlice(allocator, "<LogGroupName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.log_group_name);
    try buf.appendSlice(allocator, "</LogGroupName>");
    try buf.appendSlice(allocator, "<LogRoleArn>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.log_role_arn);
    try buf.appendSlice(allocator, "</LogRoleArn>");
}

pub fn serializeManagedExecution(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ManagedExecution) !void {
    if (value.active) |v| {
        try buf.appendSlice(allocator, "<Active>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</Active>");
    }
}

pub fn serializeOperationResultFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: OperationResultFilter) !void {
    if (value.name) |v| {
        try buf.appendSlice(allocator, "<Name>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</Name>");
    }
    if (value.values) |v| {
        try buf.appendSlice(allocator, "<Values>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Values>");
    }
}

pub fn serializeParameter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Parameter) !void {
    if (value.parameter_key) |v| {
        try buf.appendSlice(allocator, "<ParameterKey>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ParameterKey>");
    }
    if (value.parameter_value) |v| {
        try buf.appendSlice(allocator, "<ParameterValue>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ParameterValue>");
    }
    if (value.resolved_value) |v| {
        try buf.appendSlice(allocator, "<ResolvedValue>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ResolvedValue>");
    }
    if (value.use_previous_value) |v| {
        try buf.appendSlice(allocator, "<UsePreviousValue>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</UsePreviousValue>");
    }
}

pub fn serializeResourceDefinition(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResourceDefinition) !void {
    if (value.logical_resource_id) |v| {
        try buf.appendSlice(allocator, "<LogicalResourceId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</LogicalResourceId>");
    }
    try buf.appendSlice(allocator, "<ResourceIdentifier>");
    try serializeResourceIdentifierProperties(allocator, buf, value.resource_identifier, "entry");
    try buf.appendSlice(allocator, "</ResourceIdentifier>");
    try buf.appendSlice(allocator, "<ResourceType>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.resource_type);
    try buf.appendSlice(allocator, "</ResourceType>");
}

pub fn serializeResourceLocation(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResourceLocation) !void {
    try buf.appendSlice(allocator, "<LogicalResourceId>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.logical_resource_id);
    try buf.appendSlice(allocator, "</LogicalResourceId>");
    try buf.appendSlice(allocator, "<StackName>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.stack_name);
    try buf.appendSlice(allocator, "</StackName>");
}

pub fn serializeResourceMapping(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResourceMapping) !void {
    try buf.appendSlice(allocator, "<Destination>");
    try serializeResourceLocation(allocator, buf, value.destination);
    try buf.appendSlice(allocator, "</Destination>");
    try buf.appendSlice(allocator, "<Source>");
    try serializeResourceLocation(allocator, buf, value.source);
    try buf.appendSlice(allocator, "</Source>");
}

pub fn serializeResourceToImport(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResourceToImport) !void {
    try buf.appendSlice(allocator, "<LogicalResourceId>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.logical_resource_id);
    try buf.appendSlice(allocator, "</LogicalResourceId>");
    try buf.appendSlice(allocator, "<ResourceIdentifier>");
    try serializeResourceIdentifierProperties(allocator, buf, value.resource_identifier, "entry");
    try buf.appendSlice(allocator, "</ResourceIdentifier>");
    try buf.appendSlice(allocator, "<ResourceType>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.resource_type);
    try buf.appendSlice(allocator, "</ResourceType>");
}

pub fn serializeRollbackConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: RollbackConfiguration) !void {
    if (value.monitoring_time_in_minutes) |v| {
        try buf.appendSlice(allocator, "<MonitoringTimeInMinutes>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MonitoringTimeInMinutes>");
    }
    if (value.rollback_triggers) |v| {
        try buf.appendSlice(allocator, "<RollbackTriggers>");
        try serializeRollbackTriggers(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</RollbackTriggers>");
    }
}

pub fn serializeRollbackTrigger(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: RollbackTrigger) !void {
    try buf.appendSlice(allocator, "<Arn>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.arn);
    try buf.appendSlice(allocator, "</Arn>");
    try buf.appendSlice(allocator, "<Type>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.@"type");
    try buf.appendSlice(allocator, "</Type>");
}

pub fn serializeScanFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ScanFilter) !void {
    if (value.types) |v| {
        try buf.appendSlice(allocator, "<Types>");
        try serializeResourceTypeFilters(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Types>");
    }
}

pub fn serializeScannedResourceIdentifier(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ScannedResourceIdentifier) !void {
    try buf.appendSlice(allocator, "<ResourceIdentifier>");
    try serializeJazzResourceIdentifierProperties(allocator, buf, value.resource_identifier, "entry");
    try buf.appendSlice(allocator, "</ResourceIdentifier>");
    try buf.appendSlice(allocator, "<ResourceType>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.resource_type);
    try buf.appendSlice(allocator, "</ResourceType>");
}

pub fn serializeStackDefinition(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StackDefinition) !void {
    if (value.stack_name) |v| {
        try buf.appendSlice(allocator, "<StackName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</StackName>");
    }
    if (value.template_body) |v| {
        try buf.appendSlice(allocator, "<TemplateBody>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TemplateBody>");
    }
    if (value.template_url) |v| {
        try buf.appendSlice(allocator, "<TemplateURL>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TemplateURL>");
    }
}

pub fn serializeStackInstanceFilter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StackInstanceFilter) !void {
    if (value.name) |v| {
        try buf.appendSlice(allocator, "<Name>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</Name>");
    }
    if (value.values) |v| {
        try buf.appendSlice(allocator, "<Values>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Values>");
    }
}

pub fn serializeStackSetOperationPreferences(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: StackSetOperationPreferences) !void {
    if (value.concurrency_mode) |v| {
        try buf.appendSlice(allocator, "<ConcurrencyMode>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</ConcurrencyMode>");
    }
    if (value.failure_tolerance_count) |v| {
        try buf.appendSlice(allocator, "<FailureToleranceCount>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</FailureToleranceCount>");
    }
    if (value.failure_tolerance_percentage) |v| {
        try buf.appendSlice(allocator, "<FailureTolerancePercentage>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</FailureTolerancePercentage>");
    }
    if (value.max_concurrent_count) |v| {
        try buf.appendSlice(allocator, "<MaxConcurrentCount>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MaxConcurrentCount>");
    }
    if (value.max_concurrent_percentage) |v| {
        try buf.appendSlice(allocator, "<MaxConcurrentPercentage>");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try buf.appendSlice(allocator, num_str);
        }
        try buf.appendSlice(allocator, "</MaxConcurrentPercentage>");
    }
    if (value.region_concurrency_type) |v| {
        try buf.appendSlice(allocator, "<RegionConcurrencyType>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</RegionConcurrencyType>");
    }
    if (value.region_order) |v| {
        try buf.appendSlice(allocator, "<RegionOrder>");
        try serializeRegionList(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</RegionOrder>");
    }
}

pub fn serializeTag(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tag) !void {
    try buf.appendSlice(allocator, "<Key>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.key);
    try buf.appendSlice(allocator, "</Key>");
    try buf.appendSlice(allocator, "<Value>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.value);
    try buf.appendSlice(allocator, "</Value>");
}

pub fn serializeTemplateConfiguration(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TemplateConfiguration) !void {
    if (value.deletion_policy) |v| {
        try buf.appendSlice(allocator, "<DeletionPolicy>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</DeletionPolicy>");
    }
    if (value.update_replace_policy) |v| {
        try buf.appendSlice(allocator, "<UpdateReplacePolicy>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</UpdateReplacePolicy>");
    }
}

pub fn serializeTemplateSummaryConfig(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TemplateSummaryConfig) !void {
    if (value.treat_unrecognized_resource_types_as_warnings) |v| {
        try buf.appendSlice(allocator, "<TreatUnrecognizedResourceTypesAsWarnings>");
        try buf.appendSlice(allocator, if (v) "true" else "false");
        try buf.appendSlice(allocator, "</TreatUnrecognizedResourceTypesAsWarnings>");
    }
}

pub fn serializeTypeConfigurationIdentifier(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TypeConfigurationIdentifier) !void {
    if (value.@"type") |v| {
        try buf.appendSlice(allocator, "<Type>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</Type>");
    }
    if (value.type_arn) |v| {
        try buf.appendSlice(allocator, "<TypeArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TypeArn>");
    }
    if (value.type_configuration_alias) |v| {
        try buf.appendSlice(allocator, "<TypeConfigurationAlias>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TypeConfigurationAlias>");
    }
    if (value.type_configuration_arn) |v| {
        try buf.appendSlice(allocator, "<TypeConfigurationArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TypeConfigurationArn>");
    }
    if (value.type_name) |v| {
        try buf.appendSlice(allocator, "<TypeName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TypeName>");
    }
}

pub fn serializeTypeFilters(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: TypeFilters) !void {
    if (value.category) |v| {
        try buf.appendSlice(allocator, "<Category>");
        try buf.appendSlice(allocator, @tagName(v));
        try buf.appendSlice(allocator, "</Category>");
    }
    if (value.publisher_id) |v| {
        try buf.appendSlice(allocator, "<PublisherId>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</PublisherId>");
    }
    if (value.type_name_prefix) |v| {
        try buf.appendSlice(allocator, "<TypeNamePrefix>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</TypeNamePrefix>");
    }
}

