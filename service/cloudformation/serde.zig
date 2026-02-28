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

pub fn deserializeAccountLimitList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AccountLimit {
    var list: std.ArrayList(AccountLimit) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAccountLimit(reader, alloc));
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

pub fn deserializeAccountList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeAllowedValues(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeAnnotationList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Annotation {
    var list: std.ArrayList(Annotation) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAnnotation(reader, alloc));
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

pub fn deserializeBatchDescribeTypeConfigurationsErrors(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const BatchDescribeTypeConfigurationsError {
    var list: std.ArrayList(BatchDescribeTypeConfigurationsError) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeBatchDescribeTypeConfigurationsError(reader, alloc));
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

pub fn deserializeCapabilities(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Capability {
    var list: std.ArrayList(Capability) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(Capability, try reader.readElementText())) |v| try list.append(alloc, v);
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

pub fn deserializeChangeSetHooks(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ChangeSetHook {
    var list: std.ArrayList(ChangeSetHook) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeChangeSetHook(reader, alloc));
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

pub fn deserializeChangeSetSummaries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ChangeSetSummary {
    var list: std.ArrayList(ChangeSetSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeChangeSetSummary(reader, alloc));
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

pub fn deserializeChanges(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Change {
    var list: std.ArrayList(Change) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeChange(reader, alloc));
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

pub fn deserializeExports(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Export {
    var list: std.ArrayList(Export) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeExport(reader, alloc));
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

pub fn deserializeHookResultSummaries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const HookResultSummary {
    var list: std.ArrayList(HookResultSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeHookResultSummary(reader, alloc));
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

pub fn deserializeImports(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeLastOperations(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const OperationEntry {
    var list: std.ArrayList(OperationEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeOperationEntry(reader, alloc));
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

pub fn deserializeLogicalResourceIds(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeNotificationARNs(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeOperationEvents(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const OperationEvent {
    var list: std.ArrayList(OperationEvent) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeOperationEvent(reader, alloc));
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

pub fn deserializeOrganizationalUnitIdList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeOutputs(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Output {
    var list: std.ArrayList(Output) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeOutput(reader, alloc));
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

pub fn deserializeParameterDeclarations(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ParameterDeclaration {
    var list: std.ArrayList(ParameterDeclaration) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeParameterDeclaration(reader, alloc));
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

pub fn deserializeParameters(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Parameter {
    var list: std.ArrayList(Parameter) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeParameter(reader, alloc));
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

pub fn deserializePhysicalResourceIdContext(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PhysicalResourceIdContextKeyValuePair {
    var list: std.ArrayList(PhysicalResourceIdContextKeyValuePair) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePhysicalResourceIdContextKeyValuePair(reader, alloc));
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

pub fn deserializePropertyDifferences(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PropertyDifference {
    var list: std.ArrayList(PropertyDifference) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePropertyDifference(reader, alloc));
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

pub fn deserializeRegionList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeRegistrationTokenList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeRelatedResources(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ScannedResource {
    var list: std.ArrayList(ScannedResource) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeScannedResource(reader, alloc));
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

pub fn deserializeRequiredActivatedTypes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const RequiredActivatedType {
    var list: std.ArrayList(RequiredActivatedType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeRequiredActivatedType(reader, alloc));
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

pub fn deserializeResourceChangeDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ResourceChangeDetail {
    var list: std.ArrayList(ResourceChangeDetail) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeResourceChangeDetail(reader, alloc));
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

pub fn deserializeResourceDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ResourceDetail {
    var list: std.ArrayList(ResourceDetail) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeResourceDetail(reader, alloc));
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

pub fn deserializeResourceDriftIgnoredAttributes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ResourceDriftIgnoredAttribute {
    var list: std.ArrayList(ResourceDriftIgnoredAttribute) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeResourceDriftIgnoredAttribute(reader, alloc));
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

pub fn deserializeResourceIdentifierSummaries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ResourceIdentifierSummary {
    var list: std.ArrayList(ResourceIdentifierSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeResourceIdentifierSummary(reader, alloc));
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

pub fn deserializeResourceIdentifiers(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeResourceScanSummaries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ResourceScanSummary {
    var list: std.ArrayList(ResourceScanSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeResourceScanSummary(reader, alloc));
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

pub fn deserializeResourceTypeFilters(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeResourceTypes(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeRollbackTriggers(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const RollbackTrigger {
    var list: std.ArrayList(RollbackTrigger) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeRollbackTrigger(reader, alloc));
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

pub fn deserializeScanFilters(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ScanFilter {
    var list: std.ArrayList(ScanFilter) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeScanFilter(reader, alloc));
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

pub fn deserializeScannedResources(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ScannedResource {
    var list: std.ArrayList(ScannedResource) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeScannedResource(reader, alloc));
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

pub fn deserializeScope(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ResourceAttribute {
    var list: std.ArrayList(ResourceAttribute) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(ResourceAttribute, try reader.readElementText())) |v| try list.append(alloc, v);
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

pub fn deserializeStackEvents(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const StackEvent {
    var list: std.ArrayList(StackEvent) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeStackEvent(reader, alloc));
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

pub fn deserializeStackIds(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeStackInstanceResourceDriftsSummaries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const StackInstanceResourceDriftsSummary {
    var list: std.ArrayList(StackInstanceResourceDriftsSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeStackInstanceResourceDriftsSummary(reader, alloc));
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

pub fn deserializeStackInstanceSummaries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const StackInstanceSummary {
    var list: std.ArrayList(StackInstanceSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeStackInstanceSummary(reader, alloc));
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

pub fn deserializeStackRefactorActions(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const StackRefactorAction {
    var list: std.ArrayList(StackRefactorAction) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeStackRefactorAction(reader, alloc));
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

pub fn deserializeStackRefactorSummaries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const StackRefactorSummary {
    var list: std.ArrayList(StackRefactorSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeStackRefactorSummary(reader, alloc));
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

pub fn deserializeStackRefactorTagResources(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Tag {
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

pub fn deserializeStackRefactorUntagResources(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeStackResourceDrifts(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const StackResourceDrift {
    var list: std.ArrayList(StackResourceDrift) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeStackResourceDrift(reader, alloc));
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

pub fn deserializeStackResourceSummaries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const StackResourceSummary {
    var list: std.ArrayList(StackResourceSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeStackResourceSummary(reader, alloc));
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

pub fn deserializeStackResources(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const StackResource {
    var list: std.ArrayList(StackResource) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeStackResource(reader, alloc));
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

pub fn deserializeStackSetARNList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeStackSetAutoDeploymentTargetSummaries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const StackSetAutoDeploymentTargetSummary {
    var list: std.ArrayList(StackSetAutoDeploymentTargetSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeStackSetAutoDeploymentTargetSummary(reader, alloc));
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

pub fn deserializeStackSetOperationResultSummaries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const StackSetOperationResultSummary {
    var list: std.ArrayList(StackSetOperationResultSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeStackSetOperationResultSummary(reader, alloc));
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

pub fn deserializeStackSetOperationSummaries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const StackSetOperationSummary {
    var list: std.ArrayList(StackSetOperationSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeStackSetOperationSummary(reader, alloc));
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

pub fn deserializeStackSetSummaries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const StackSetSummary {
    var list: std.ArrayList(StackSetSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeStackSetSummary(reader, alloc));
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

pub fn deserializeStackSummaries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const StackSummary {
    var list: std.ArrayList(StackSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeStackSummary(reader, alloc));
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

pub fn deserializeStacks(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Stack {
    var list: std.ArrayList(Stack) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeStack(reader, alloc));
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

pub fn deserializeStageList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TemplateStage {
    var list: std.ArrayList(TemplateStage) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(TemplateStage, try reader.readElementText())) |v| try list.append(alloc, v);
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

pub fn deserializeSupportedMajorVersions(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const i32 {
    var list: std.ArrayList(i32) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null) |v| try list.append(alloc, v);
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

pub fn deserializeTags(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Tag {
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

pub fn deserializeTemplateParameters(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TemplateParameter {
    var list: std.ArrayList(TemplateParameter) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTemplateParameter(reader, alloc));
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

pub fn deserializeTemplateSummaries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TemplateSummary {
    var list: std.ArrayList(TemplateSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTemplateSummary(reader, alloc));
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

pub fn deserializeTransformsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
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

pub fn deserializeTypeConfigurationDetailsList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TypeConfigurationDetails {
    var list: std.ArrayList(TypeConfigurationDetails) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTypeConfigurationDetails(reader, alloc));
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

pub fn deserializeTypeSummaries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TypeSummary {
    var list: std.ArrayList(TypeSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTypeSummary(reader, alloc));
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

pub fn deserializeTypeVersionSummaries(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TypeVersionSummary {
    var list: std.ArrayList(TypeVersionSummary) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTypeVersionSummary(reader, alloc));
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

pub fn deserializeUnprocessedTypeConfigurations(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TypeConfigurationIdentifier {
    var list: std.ArrayList(TypeConfigurationIdentifier) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTypeConfigurationIdentifier(reader, alloc));
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

pub fn deserializeWarningDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const WarningDetail {
    var list: std.ArrayList(WarningDetail) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeWarningDetail(reader, alloc));
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

pub fn deserializeWarningProperties(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const WarningProperty {
    var list: std.ArrayList(WarningProperty) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeWarningProperty(reader, alloc));
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

pub fn deserializeJazzResourceIdentifierProperties(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
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

pub fn deserializeResourceIdentifierProperties(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
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

pub fn deserializeAccountGateResult(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AccountGateResult {
    var result: AccountGateResult = undefined;
    result.status = null;
    result.status_reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(AccountGateStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeAccountLimit(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AccountLimit {
    var result: AccountLimit = undefined;
    result.name = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeAnnotation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Annotation {
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
                    result.annotation_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RemediationLink")) {
                    result.remediation_link = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RemediationMessage")) {
                    result.remediation_message = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SeverityLevel")) {
                    result.severity_level = std.meta.stringToEnum(AnnotationSeverityLevel, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(AnnotationStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusMessage")) {
                    result.status_message = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeAutoDeployment(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AutoDeployment {
    var result: AutoDeployment = undefined;
    result.depends_on = null;
    result.enabled = null;
    result.retain_stacks_on_account_removal = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DependsOn")) {
                    result.depends_on = try deserializeStackSetARNList(reader, alloc, "member");
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

pub fn deserializeBatchDescribeTypeConfigurationsError(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !BatchDescribeTypeConfigurationsError {
    var result: BatchDescribeTypeConfigurationsError = undefined;
    result.error_code = null;
    result.error_message = null;
    result.type_configuration_identifier = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ErrorCode")) {
                    result.error_code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ErrorMessage")) {
                    result.error_message = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeConfigurationIdentifier")) {
                    result.type_configuration_identifier = try deserializeTypeConfigurationIdentifier(reader, alloc);
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

pub fn deserializeChange(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Change {
    var result: Change = undefined;
    result.hook_invocation_count = null;
    result.resource_change = null;
    result.type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HookInvocationCount")) {
                    result.hook_invocation_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ResourceChange")) {
                    result.resource_change = try deserializeResourceChange(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.type = std.meta.stringToEnum(ChangeType, try reader.readElementText());
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

pub fn deserializeChangeSetHook(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ChangeSetHook {
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
                    result.target_details = try deserializeChangeSetHookTargetDetails(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "TypeConfigurationVersionId")) {
                    result.type_configuration_version_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeName")) {
                    result.type_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeVersionId")) {
                    result.type_version_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeChangeSetHookResourceTargetDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ChangeSetHookResourceTargetDetails {
    var result: ChangeSetHookResourceTargetDetails = undefined;
    result.logical_resource_id = null;
    result.resource_action = null;
    result.resource_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LogicalResourceId")) {
                    result.logical_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceAction")) {
                    result.resource_action = std.meta.stringToEnum(ChangeAction, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeChangeSetHookTargetDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ChangeSetHookTargetDetails {
    var result: ChangeSetHookTargetDetails = undefined;
    result.resource_target_details = null;
    result.target_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ResourceTargetDetails")) {
                    result.resource_target_details = try deserializeChangeSetHookResourceTargetDetails(reader, alloc);
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

pub fn deserializeChangeSetSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ChangeSetSummary {
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
                    result.change_set_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChangeSetName")) {
                    result.change_set_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreationTime")) {
                    result.creation_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExecutionStatus")) {
                    result.execution_status = std.meta.stringToEnum(ExecutionStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ImportExistingResources")) {
                    result.import_existing_resources = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "IncludeNestedStacks")) {
                    result.include_nested_stacks = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ParentChangeSetId")) {
                    result.parent_change_set_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RootChangeSetId")) {
                    result.root_change_set_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackName")) {
                    result.stack_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(ChangeSetStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDeploymentTargets(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DeploymentTargets {
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
                    result.accounts = try deserializeAccountList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "AccountsUrl")) {
                    result.accounts_url = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OrganizationalUnitIds")) {
                    result.organizational_unit_ids = try deserializeOrganizationalUnitIdList(reader, alloc, "member");
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

pub fn deserializeExport(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Export {
    var result: Export = undefined;
    result.exporting_stack_id = null;
    result.name = null;
    result.value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ExportingStackId")) {
                    result.exporting_stack_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
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

pub fn deserializeHookResultSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !HookResultSummary {
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
                    result.hook_execution_target = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookResultId")) {
                    result.hook_result_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookStatusReason")) {
                    result.hook_status_reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InvocationPoint")) {
                    result.invocation_point = std.meta.stringToEnum(HookInvocationPoint, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InvokedAt")) {
                    result.invoked_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(HookStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetId")) {
                    result.target_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetType")) {
                    result.target_type = std.meta.stringToEnum(ListHookResultsTargetType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeArn")) {
                    result.type_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeConfigurationVersionId")) {
                    result.type_configuration_version_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeName")) {
                    result.type_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeVersionId")) {
                    result.type_version_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeHookTarget(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !HookTarget {
    var result: HookTarget = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Action")) {
                    result.action = std.meta.stringToEnum(HookTargetAction, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetId")) {
                    result.target_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetType")) {
                    result.target_type = std.meta.stringToEnum(HookTargetType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TargetTypeName")) {
                    result.target_type_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeLiveResourceDrift(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LiveResourceDrift {
    var result: LiveResourceDrift = undefined;
    result.actual_value = null;
    result.drift_detection_timestamp = null;
    result.previous_value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActualValue")) {
                    result.actual_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DriftDetectionTimestamp")) {
                    result.drift_detection_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "PreviousValue")) {
                    result.previous_value = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeLoggingConfig(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LoggingConfig {
    var result: LoggingConfig = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LogGroupName")) {
                    result.log_group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogRoleArn")) {
                    result.log_role_arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeManagedExecution(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ManagedExecution {
    _ = alloc;
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

pub fn deserializeModuleInfo(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ModuleInfo {
    var result: ModuleInfo = undefined;
    result.logical_id_hierarchy = null;
    result.type_hierarchy = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LogicalIdHierarchy")) {
                    result.logical_id_hierarchy = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeHierarchy")) {
                    result.type_hierarchy = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeOperationEntry(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OperationEntry {
    var result: OperationEntry = undefined;
    result.operation_id = null;
    result.operation_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OperationId")) {
                    result.operation_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeOperationEvent(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OperationEvent {
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
                    result.client_request_token = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DetailedStatus")) {
                    result.detailed_status = std.meta.stringToEnum(DetailedStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EndTime")) {
                    result.end_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "EventId")) {
                    result.event_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EventType")) {
                    result.event_type = std.meta.stringToEnum(EventType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookFailureMode")) {
                    result.hook_failure_mode = std.meta.stringToEnum(HookFailureMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookInvocationPoint")) {
                    result.hook_invocation_point = std.meta.stringToEnum(HookInvocationPoint, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookStatus")) {
                    result.hook_status = std.meta.stringToEnum(HookStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookStatusReason")) {
                    result.hook_status_reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookType")) {
                    result.hook_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogicalResourceId")) {
                    result.logical_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperationId")) {
                    result.operation_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperationStatus")) {
                    result.operation_status = std.meta.stringToEnum(BeaconStackOperationStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperationType")) {
                    result.operation_type = std.meta.stringToEnum(OperationType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PhysicalResourceId")) {
                    result.physical_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceProperties")) {
                    result.resource_properties = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceStatus")) {
                    result.resource_status = std.meta.stringToEnum(ResourceStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceStatusReason")) {
                    result.resource_status_reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StartTime")) {
                    result.start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Timestamp")) {
                    result.timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ValidationFailureMode")) {
                    result.validation_failure_mode = std.meta.stringToEnum(HookFailureMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ValidationName")) {
                    result.validation_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ValidationPath")) {
                    result.validation_path = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ValidationStatus")) {
                    result.validation_status = std.meta.stringToEnum(ValidationStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ValidationStatusReason")) {
                    result.validation_status_reason = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeOutput(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Output {
    var result: Output = undefined;
    result.description = null;
    result.export_name = null;
    result.output_key = null;
    result.output_value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExportName")) {
                    result.export_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OutputKey")) {
                    result.output_key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OutputValue")) {
                    result.output_value = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeParameter(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Parameter {
    var result: Parameter = undefined;
    result.parameter_key = null;
    result.parameter_value = null;
    result.resolved_value = null;
    result.use_previous_value = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ParameterKey")) {
                    result.parameter_key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ParameterValue")) {
                    result.parameter_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResolvedValue")) {
                    result.resolved_value = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeParameterConstraints(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ParameterConstraints {
    var result: ParameterConstraints = undefined;
    result.allowed_values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowedValues")) {
                    result.allowed_values = try deserializeAllowedValues(reader, alloc, "member");
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

pub fn deserializeParameterDeclaration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ParameterDeclaration {
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
                    result.default_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NoEcho")) {
                    result.no_echo = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ParameterConstraints")) {
                    result.parameter_constraints = try deserializeParameterConstraints(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ParameterKey")) {
                    result.parameter_key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ParameterType")) {
                    result.parameter_type = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializePhysicalResourceIdContextKeyValuePair(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PhysicalResourceIdContextKeyValuePair {
    var result: PhysicalResourceIdContextKeyValuePair = undefined;
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

pub fn deserializePropertyDifference(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PropertyDifference {
    var result: PropertyDifference = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActualValue")) {
                    result.actual_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DifferenceType")) {
                    result.difference_type = std.meta.stringToEnum(DifferenceType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExpectedValue")) {
                    result.expected_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PropertyPath")) {
                    result.property_path = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeRequiredActivatedType(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RequiredActivatedType {
    var result: RequiredActivatedType = undefined;
    result.original_type_name = null;
    result.publisher_id = null;
    result.supported_major_versions = null;
    result.type_name_alias = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OriginalTypeName")) {
                    result.original_type_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublisherId")) {
                    result.publisher_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportedMajorVersions")) {
                    result.supported_major_versions = try deserializeSupportedMajorVersions(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "TypeNameAlias")) {
                    result.type_name_alias = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeResourceChange(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResourceChange {
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
                    result.after_context = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BeforeContext")) {
                    result.before_context = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChangeSetId")) {
                    result.change_set_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Details")) {
                    result.details = try deserializeResourceChangeDetails(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "LogicalResourceId")) {
                    result.logical_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ModuleInfo")) {
                    result.module_info = try deserializeModuleInfo(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PhysicalResourceId")) {
                    result.physical_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyAction")) {
                    result.policy_action = std.meta.stringToEnum(PolicyAction, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PreviousDeploymentContext")) {
                    result.previous_deployment_context = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Replacement")) {
                    result.replacement = std.meta.stringToEnum(Replacement, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceDriftIgnoredAttributes")) {
                    result.resource_drift_ignored_attributes = try deserializeResourceDriftIgnoredAttributes(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ResourceDriftStatus")) {
                    result.resource_drift_status = std.meta.stringToEnum(StackResourceDriftStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Scope")) {
                    result.scope = try deserializeScope(reader, alloc, "member");
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

pub fn deserializeResourceChangeDetail(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResourceChangeDetail {
    var result: ResourceChangeDetail = undefined;
    result.causing_entity = null;
    result.change_source = null;
    result.evaluation = null;
    result.target = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CausingEntity")) {
                    result.causing_entity = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ChangeSource")) {
                    result.change_source = std.meta.stringToEnum(ChangeSource, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Evaluation")) {
                    result.evaluation = std.meta.stringToEnum(EvaluationType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Target")) {
                    result.target = try deserializeResourceTargetDefinition(reader, alloc);
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

pub fn deserializeResourceDetail(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResourceDetail {
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
                    result.logical_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceIdentifier")) {
                    result.resource_identifier = try deserializeResourceIdentifierProperties(reader, alloc, "entry");
                } else if (std.mem.eql(u8, e.local, "ResourceStatus")) {
                    result.resource_status = std.meta.stringToEnum(GeneratedTemplateResourceStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceStatusReason")) {
                    result.resource_status_reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Warnings")) {
                    result.warnings = try deserializeWarningDetails(reader, alloc, "member");
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

pub fn deserializeResourceDriftIgnoredAttribute(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResourceDriftIgnoredAttribute {
    var result: ResourceDriftIgnoredAttribute = undefined;
    result.path = null;
    result.reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeResourceIdentifierSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResourceIdentifierSummary {
    var result: ResourceIdentifierSummary = undefined;
    result.logical_resource_ids = null;
    result.resource_identifiers = null;
    result.resource_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LogicalResourceIds")) {
                    result.logical_resource_ids = try deserializeLogicalResourceIds(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ResourceIdentifiers")) {
                    result.resource_identifiers = try deserializeResourceIdentifiers(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeResourceLocation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResourceLocation {
    var result: ResourceLocation = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LogicalResourceId")) {
                    result.logical_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackName")) {
                    result.stack_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeResourceMapping(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResourceMapping {
    var result: ResourceMapping = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Destination")) {
                    result.destination = try deserializeResourceLocation(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Source")) {
                    result.source = try deserializeResourceLocation(reader, alloc);
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

pub fn deserializeResourceScanSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResourceScanSummary {
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
                    result.resource_scan_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ScanType")) {
                    result.scan_type = std.meta.stringToEnum(ScanType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StartTime")) {
                    result.start_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(ResourceScanStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeResourceTargetDefinition(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResourceTargetDefinition {
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
                    result.after_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AfterValueFrom")) {
                    result.after_value_from = std.meta.stringToEnum(AfterValueFrom, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Attribute")) {
                    result.attribute = std.meta.stringToEnum(ResourceAttribute, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AttributeChangeType")) {
                    result.attribute_change_type = std.meta.stringToEnum(AttributeChangeType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BeforeValue")) {
                    result.before_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "BeforeValueFrom")) {
                    result.before_value_from = std.meta.stringToEnum(BeforeValueFrom, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Drift")) {
                    result.drift = try deserializeLiveResourceDrift(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeRollbackConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RollbackConfiguration {
    var result: RollbackConfiguration = undefined;
    result.monitoring_time_in_minutes = null;
    result.rollback_triggers = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MonitoringTimeInMinutes")) {
                    result.monitoring_time_in_minutes = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "RollbackTriggers")) {
                    result.rollback_triggers = try deserializeRollbackTriggers(reader, alloc, "member");
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

pub fn deserializeRollbackTrigger(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RollbackTrigger {
    var result: RollbackTrigger = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.type = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeScanFilter(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ScanFilter {
    var result: ScanFilter = undefined;
    result.types = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Types")) {
                    result.types = try deserializeResourceTypeFilters(reader, alloc, "member");
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

pub fn deserializeScannedResource(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ScannedResource {
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
                    result.resource_identifier = try deserializeJazzResourceIdentifierProperties(reader, alloc, "entry");
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeStack(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Stack {
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
                    result.capabilities = try deserializeCapabilities(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ChangeSetId")) {
                    result.change_set_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreationTime")) {
                    result.creation_time = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DeletionMode")) {
                    result.deletion_mode = std.meta.stringToEnum(DeletionMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DeletionTime")) {
                    result.deletion_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DetailedStatus")) {
                    result.detailed_status = std.meta.stringToEnum(DetailedStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DisableRollback")) {
                    result.disable_rollback = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "DriftInformation")) {
                    result.drift_information = try deserializeStackDriftInformation(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "EnableTerminationProtection")) {
                    result.enable_termination_protection = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "LastOperations")) {
                    result.last_operations = try deserializeLastOperations(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "LastUpdatedTime")) {
                    result.last_updated_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NotificationARNs")) {
                    result.notification_ar_ns = try deserializeNotificationARNs(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Outputs")) {
                    result.outputs = try deserializeOutputs(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Parameters")) {
                    result.parameters = try deserializeParameters(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ParentId")) {
                    result.parent_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RetainExceptOnCreate")) {
                    result.retain_except_on_create = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "RoleARN")) {
                    result.role_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RollbackConfiguration")) {
                    result.rollback_configuration = try deserializeRollbackConfiguration(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "RootId")) {
                    result.root_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackName")) {
                    result.stack_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackStatus")) {
                    result.stack_status = std.meta.stringToEnum(StackStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackStatusReason")) {
                    result.stack_status_reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTags(reader, alloc, "member");
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

pub fn deserializeStackDriftInformation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackDriftInformation {
    _ = alloc;
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

pub fn deserializeStackDriftInformationSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackDriftInformationSummary {
    _ = alloc;
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

pub fn deserializeStackEvent(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackEvent {
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
                    result.client_request_token = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DetailedStatus")) {
                    result.detailed_status = std.meta.stringToEnum(DetailedStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EventId")) {
                    result.event_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookFailureMode")) {
                    result.hook_failure_mode = std.meta.stringToEnum(HookFailureMode, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookInvocationId")) {
                    result.hook_invocation_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookInvocationPoint")) {
                    result.hook_invocation_point = std.meta.stringToEnum(HookInvocationPoint, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookStatus")) {
                    result.hook_status = std.meta.stringToEnum(HookStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookStatusReason")) {
                    result.hook_status_reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookType")) {
                    result.hook_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogicalResourceId")) {
                    result.logical_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperationId")) {
                    result.operation_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PhysicalResourceId")) {
                    result.physical_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceProperties")) {
                    result.resource_properties = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceStatus")) {
                    result.resource_status = std.meta.stringToEnum(ResourceStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceStatusReason")) {
                    result.resource_status_reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackName")) {
                    result.stack_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackInstance(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackInstance {
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
                    result.account = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DriftStatus")) {
                    result.drift_status = std.meta.stringToEnum(StackDriftStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastDriftCheckTimestamp")) {
                    result.last_drift_check_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "LastOperationId")) {
                    result.last_operation_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OrganizationalUnitId")) {
                    result.organizational_unit_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ParameterOverrides")) {
                    result.parameter_overrides = try deserializeParameters(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackInstanceStatus")) {
                    result.stack_instance_status = try deserializeStackInstanceComprehensiveStatus(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "StackSetId")) {
                    result.stack_set_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(StackInstanceStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackInstanceComprehensiveStatus(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackInstanceComprehensiveStatus {
    _ = alloc;
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

pub fn deserializeStackInstanceResourceDriftsSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackInstanceResourceDriftsSummary {
    var result: StackInstanceResourceDriftsSummary = undefined;
    result.physical_resource_id = null;
    result.physical_resource_id_context = null;
    result.property_differences = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LogicalResourceId")) {
                    result.logical_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PhysicalResourceId")) {
                    result.physical_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PhysicalResourceIdContext")) {
                    result.physical_resource_id_context = try deserializePhysicalResourceIdContext(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "PropertyDifferences")) {
                    result.property_differences = try deserializePropertyDifferences(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackInstanceSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackInstanceSummary {
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
                    result.account = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DriftStatus")) {
                    result.drift_status = std.meta.stringToEnum(StackDriftStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastDriftCheckTimestamp")) {
                    result.last_drift_check_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "LastOperationId")) {
                    result.last_operation_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OrganizationalUnitId")) {
                    result.organizational_unit_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackInstanceStatus")) {
                    result.stack_instance_status = try deserializeStackInstanceComprehensiveStatus(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "StackSetId")) {
                    result.stack_set_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(StackInstanceStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackRefactorAction(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackRefactorAction {
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
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Detection")) {
                    result.detection = std.meta.stringToEnum(StackRefactorDetection, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DetectionReason")) {
                    result.detection_reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Entity")) {
                    result.entity = std.meta.stringToEnum(StackRefactorActionEntity, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PhysicalResourceId")) {
                    result.physical_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceIdentifier")) {
                    result.resource_identifier = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceMapping")) {
                    result.resource_mapping = try deserializeResourceMapping(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "TagResources")) {
                    result.tag_resources = try deserializeStackRefactorTagResources(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "UntagResources")) {
                    result.untag_resources = try deserializeStackRefactorUntagResources(reader, alloc, "member");
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

pub fn deserializeStackRefactorSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackRefactorSummary {
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
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExecutionStatus")) {
                    result.execution_status = std.meta.stringToEnum(StackRefactorExecutionStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExecutionStatusReason")) {
                    result.execution_status_reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackRefactorId")) {
                    result.stack_refactor_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(StackRefactorStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackResource(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackResource {
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
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DriftInformation")) {
                    result.drift_information = try deserializeStackResourceDriftInformation(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "LogicalResourceId")) {
                    result.logical_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ModuleInfo")) {
                    result.module_info = try deserializeModuleInfo(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PhysicalResourceId")) {
                    result.physical_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceStatus")) {
                    result.resource_status = std.meta.stringToEnum(ResourceStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceStatusReason")) {
                    result.resource_status_reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackName")) {
                    result.stack_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackResourceDetail(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackResourceDetail {
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
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DriftInformation")) {
                    result.drift_information = try deserializeStackResourceDriftInformation(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "LastUpdatedTimestamp")) {
                    result.last_updated_timestamp = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogicalResourceId")) {
                    result.logical_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Metadata")) {
                    result.metadata = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ModuleInfo")) {
                    result.module_info = try deserializeModuleInfo(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PhysicalResourceId")) {
                    result.physical_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceStatus")) {
                    result.resource_status = std.meta.stringToEnum(ResourceStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceStatusReason")) {
                    result.resource_status_reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackName")) {
                    result.stack_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackResourceDrift(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackResourceDrift {
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
                    result.actual_properties = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DriftStatusReason")) {
                    result.drift_status_reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExpectedProperties")) {
                    result.expected_properties = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogicalResourceId")) {
                    result.logical_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ModuleInfo")) {
                    result.module_info = try deserializeModuleInfo(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PhysicalResourceId")) {
                    result.physical_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PhysicalResourceIdContext")) {
                    result.physical_resource_id_context = try deserializePhysicalResourceIdContext(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "PropertyDifferences")) {
                    result.property_differences = try deserializePropertyDifferences(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackResourceDriftInformation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackResourceDriftInformation {
    _ = alloc;
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

pub fn deserializeStackResourceDriftInformationSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackResourceDriftInformationSummary {
    _ = alloc;
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

pub fn deserializeStackResourceSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackResourceSummary {
    var result: StackResourceSummary = undefined;
    result.drift_information = null;
    result.module_info = null;
    result.physical_resource_id = null;
    result.resource_status_reason = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DriftInformation")) {
                    result.drift_information = try deserializeStackResourceDriftInformationSummary(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "LastUpdatedTimestamp")) {
                    result.last_updated_timestamp = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LogicalResourceId")) {
                    result.logical_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ModuleInfo")) {
                    result.module_info = try deserializeModuleInfo(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PhysicalResourceId")) {
                    result.physical_resource_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceStatus")) {
                    result.resource_status = std.meta.stringToEnum(ResourceStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceStatusReason")) {
                    result.resource_status_reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ResourceType")) {
                    result.resource_type = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackSet(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackSet {
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
                    result.administration_role_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AutoDeployment")) {
                    result.auto_deployment = try deserializeAutoDeployment(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Capabilities")) {
                    result.capabilities = try deserializeCapabilities(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExecutionRoleName")) {
                    result.execution_role_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ManagedExecution")) {
                    result.managed_execution = try deserializeManagedExecution(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "OrganizationalUnitIds")) {
                    result.organizational_unit_ids = try deserializeOrganizationalUnitIdList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Parameters")) {
                    result.parameters = try deserializeParameters(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "PermissionModel")) {
                    result.permission_model = std.meta.stringToEnum(PermissionModels, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Regions")) {
                    result.regions = try deserializeRegionList(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "StackSetARN")) {
                    result.stack_set_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackSetDriftDetectionDetails")) {
                    result.stack_set_drift_detection_details = try deserializeStackSetDriftDetectionDetails(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "StackSetId")) {
                    result.stack_set_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackSetName")) {
                    result.stack_set_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(StackSetStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializeTags(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "TemplateBody")) {
                    result.template_body = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackSetAutoDeploymentTargetSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackSetAutoDeploymentTargetSummary {
    var result: StackSetAutoDeploymentTargetSummary = undefined;
    result.organizational_unit_id = null;
    result.regions = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OrganizationalUnitId")) {
                    result.organizational_unit_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Regions")) {
                    result.regions = try deserializeRegionList(reader, alloc, "member");
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

pub fn deserializeStackSetDriftDetectionDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackSetDriftDetectionDetails {
    _ = alloc;
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

pub fn deserializeStackSetOperation(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackSetOperation {
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
                    result.administration_role_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreationTimestamp")) {
                    result.creation_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DeploymentTargets")) {
                    result.deployment_targets = try deserializeDeploymentTargets(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "EndTimestamp")) {
                    result.end_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ExecutionRoleName")) {
                    result.execution_role_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperationId")) {
                    result.operation_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperationPreferences")) {
                    result.operation_preferences = try deserializeStackSetOperationPreferences(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "RetainStacks")) {
                    result.retain_stacks = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "StackSetDriftDetectionDetails")) {
                    result.stack_set_drift_detection_details = try deserializeStackSetDriftDetectionDetails(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "StackSetId")) {
                    result.stack_set_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(StackSetOperationStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusDetails")) {
                    result.status_details = try deserializeStackSetOperationStatusDetails(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackSetOperationPreferences(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackSetOperationPreferences {
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
                    result.region_order = try deserializeRegionList(reader, alloc, "member");
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

pub fn deserializeStackSetOperationResultSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackSetOperationResultSummary {
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
                    result.account = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AccountGateResult")) {
                    result.account_gate_result = try deserializeAccountGateResult(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "OrganizationalUnitId")) {
                    result.organizational_unit_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(StackSetOperationResultStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackSetOperationStatusDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackSetOperationStatusDetails {
    _ = alloc;
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

pub fn deserializeStackSetOperationSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackSetOperationSummary {
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
                    result.operation_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OperationPreferences")) {
                    result.operation_preferences = try deserializeStackSetOperationPreferences(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(StackSetOperationStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusDetails")) {
                    result.status_details = try deserializeStackSetOperationStatusDetails(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackSetSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackSetSummary {
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
                    result.auto_deployment = try deserializeAutoDeployment(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DriftStatus")) {
                    result.drift_status = std.meta.stringToEnum(StackDriftStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastDriftCheckTimestamp")) {
                    result.last_drift_check_timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ManagedExecution")) {
                    result.managed_execution = try deserializeManagedExecution(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PermissionModel")) {
                    result.permission_model = std.meta.stringToEnum(PermissionModels, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackSetId")) {
                    result.stack_set_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackSetName")) {
                    result.stack_set_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeStackSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !StackSummary {
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
                    result.drift_information = try deserializeStackDriftInformationSummary(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "LastOperations")) {
                    result.last_operations = try deserializeLastOperations(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "LastUpdatedTime")) {
                    result.last_updated_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ParentId")) {
                    result.parent_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RootId")) {
                    result.root_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackId")) {
                    result.stack_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackName")) {
                    result.stack_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackStatus")) {
                    result.stack_status = std.meta.stringToEnum(StackStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackStatusReason")) {
                    result.stack_status_reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TemplateDescription")) {
                    result.template_description = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeTemplateConfiguration(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TemplateConfiguration {
    _ = alloc;
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

pub fn deserializeTemplateParameter(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TemplateParameter {
    var result: TemplateParameter = undefined;
    result.default_value = null;
    result.description = null;
    result.no_echo = null;
    result.parameter_key = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DefaultValue")) {
                    result.default_value = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "NoEcho")) {
                    result.no_echo = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ParameterKey")) {
                    result.parameter_key = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeTemplateProgress(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TemplateProgress {
    _ = alloc;
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

pub fn deserializeTemplateSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TemplateSummary {
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
                    result.generated_template_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GeneratedTemplateName")) {
                    result.generated_template_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastUpdatedTime")) {
                    result.last_updated_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "NumberOfResources")) {
                    result.number_of_resources = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(GeneratedTemplateStatus, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeTypeConfigurationDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TypeConfigurationDetails {
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
                    result.alias = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Configuration")) {
                    result.configuration = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsDefaultConfiguration")) {
                    result.is_default_configuration = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "LastUpdated")) {
                    result.last_updated = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "TypeArn")) {
                    result.type_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeName")) {
                    result.type_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeTypeConfigurationIdentifier(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TypeConfigurationIdentifier {
    var result: TypeConfigurationIdentifier = undefined;
    result.type = null;
    result.type_arn = null;
    result.type_configuration_alias = null;
    result.type_configuration_arn = null;
    result.type_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Type")) {
                    result.type = std.meta.stringToEnum(ThirdPartyType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeArn")) {
                    result.type_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeConfigurationAlias")) {
                    result.type_configuration_alias = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeConfigurationArn")) {
                    result.type_configuration_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeName")) {
                    result.type_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeTypeSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TypeSummary {
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
    result.type = null;
    result.type_arn = null;
    result.type_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DefaultVersionId")) {
                    result.default_version_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsActivated")) {
                    result.is_activated = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "LastUpdated")) {
                    result.last_updated = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "LatestPublicVersion")) {
                    result.latest_public_version = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OriginalTypeName")) {
                    result.original_type_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublicVersionNumber")) {
                    result.public_version_number = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublisherId")) {
                    result.publisher_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublisherIdentity")) {
                    result.publisher_identity = std.meta.stringToEnum(IdentityProvider, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PublisherName")) {
                    result.publisher_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.type = std.meta.stringToEnum(RegistryType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeArn")) {
                    result.type_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeName")) {
                    result.type_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeTypeVersionSummary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TypeVersionSummary {
    var result: TypeVersionSummary = undefined;
    result.arn = null;
    result.description = null;
    result.is_default_version = null;
    result.public_version_number = null;
    result.time_created = null;
    result.type = null;
    result.type_name = null;
    result.version_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsDefaultVersion")) {
                    result.is_default_version = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "PublicVersionNumber")) {
                    result.public_version_number = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TimeCreated")) {
                    result.time_created = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.type = std.meta.stringToEnum(RegistryType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeName")) {
                    result.type_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "VersionId")) {
                    result.version_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeWarningDetail(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !WarningDetail {
    var result: WarningDetail = undefined;
    result.properties = null;
    result.type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Properties")) {
                    result.properties = try deserializeWarningProperties(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.type = std.meta.stringToEnum(WarningType, try reader.readElementText());
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

pub fn deserializeWarningProperty(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !WarningProperty {
    var result: WarningProperty = undefined;
    result.description = null;
    result.property_path = null;
    result.required = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PropertyPath")) {
                    result.property_path = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeWarnings(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Warnings {
    var result: Warnings = undefined;
    result.unrecognized_resource_types = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "UnrecognizedResourceTypes")) {
                    result.unrecognized_resource_types = try deserializeResourceTypes(reader, alloc, "member");
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

pub fn serializeAccountList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeCapabilities(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Capability, comptime item_tag: []const u8) !void {
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

pub fn serializeJazzLogicalResourceIds(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeLogicalResourceIds(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeNotificationARNs(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeOperationResultFilters(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const OperationResultFilter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeOperationResultFilter(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeOrganizationalUnitIdList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeParameters(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Parameter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeParameter(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeRegionList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeResourceDefinitions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ResourceDefinition, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeResourceDefinition(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeResourceMappings(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ResourceMapping, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeResourceMapping(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeResourceTypeFilters(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeResourceTypes(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeResourcesToImport(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ResourceToImport, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeResourceToImport(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeResourcesToSkip(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeRetainResources(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeRollbackTriggers(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const RollbackTrigger, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeRollbackTrigger(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeScanFilters(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ScanFilter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeScanFilter(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeScannedResourceIdentifiers(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ScannedResourceIdentifier, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeScannedResourceIdentifier(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeStackDefinitions(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const StackDefinition, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeStackDefinition(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeStackIdList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeStackInstanceFilters(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const StackInstanceFilter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeStackInstanceFilter(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeStackRefactorExecutionStatusFilter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const StackRefactorExecutionStatus, comptime item_tag: []const u8) !void {
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

pub fn serializeStackResourceDriftStatusFilters(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const StackResourceDriftStatus, comptime item_tag: []const u8) !void {
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

pub fn serializeStackSetARNList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
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

pub fn serializeStackStatusFilter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const StackStatus, comptime item_tag: []const u8) !void {
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

pub fn serializeTags(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Tag, comptime item_tag: []const u8) !void {
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

pub fn serializeTypeConfigurationIdentifiers(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const TypeConfigurationIdentifier, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(alloc, "<");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
        try serializeTypeConfigurationIdentifier(alloc, buf, item);
        try buf.appendSlice(alloc, "</");
        try buf.appendSlice(alloc, item_tag);
        try buf.appendSlice(alloc, ">");
    }
}

pub fn serializeJazzResourceIdentifierProperties(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.StringMapEntry, comptime entry_tag: []const u8) !void {
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

pub fn serializeResourceIdentifierProperties(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const aws.map.StringMapEntry, comptime entry_tag: []const u8) !void {
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

pub fn serializeAutoDeployment(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: AutoDeployment) !void {
    if (value.depends_on) |v| {
        try buf.appendSlice(alloc, "<DependsOn>");
        try serializeStackSetARNList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</DependsOn>");
    }
    if (value.enabled) |v| {
        try buf.appendSlice(alloc, "<Enabled>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</Enabled>");
    }
    if (value.retain_stacks_on_account_removal) |v| {
        try buf.appendSlice(alloc, "<RetainStacksOnAccountRemoval>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</RetainStacksOnAccountRemoval>");
    }
}

pub fn serializeDeploymentTargets(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: DeploymentTargets) !void {
    if (value.account_filter_type) |v| {
        try buf.appendSlice(alloc, "<AccountFilterType>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</AccountFilterType>");
    }
    if (value.accounts) |v| {
        try buf.appendSlice(alloc, "<Accounts>");
        try serializeAccountList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Accounts>");
    }
    if (value.accounts_url) |v| {
        try buf.appendSlice(alloc, "<AccountsUrl>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</AccountsUrl>");
    }
    if (value.organizational_unit_ids) |v| {
        try buf.appendSlice(alloc, "<OrganizationalUnitIds>");
        try serializeOrganizationalUnitIdList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</OrganizationalUnitIds>");
    }
}

pub fn serializeEventFilter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: EventFilter) !void {
    if (value.failed_events) |v| {
        try buf.appendSlice(alloc, "<FailedEvents>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</FailedEvents>");
    }
}

pub fn serializeLoggingConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: LoggingConfig) !void {
    try buf.appendSlice(alloc, "<LogGroupName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.log_group_name);
    try buf.appendSlice(alloc, "</LogGroupName>");
    try buf.appendSlice(alloc, "<LogRoleArn>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.log_role_arn);
    try buf.appendSlice(alloc, "</LogRoleArn>");
}

pub fn serializeManagedExecution(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ManagedExecution) !void {
    if (value.active) |v| {
        try buf.appendSlice(alloc, "<Active>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</Active>");
    }
}

pub fn serializeOperationResultFilter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: OperationResultFilter) !void {
    if (value.name) |v| {
        try buf.appendSlice(alloc, "<Name>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</Name>");
    }
    if (value.values) |v| {
        try buf.appendSlice(alloc, "<Values>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Values>");
    }
}

pub fn serializeParameter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Parameter) !void {
    if (value.parameter_key) |v| {
        try buf.appendSlice(alloc, "<ParameterKey>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ParameterKey>");
    }
    if (value.parameter_value) |v| {
        try buf.appendSlice(alloc, "<ParameterValue>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ParameterValue>");
    }
    if (value.resolved_value) |v| {
        try buf.appendSlice(alloc, "<ResolvedValue>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</ResolvedValue>");
    }
    if (value.use_previous_value) |v| {
        try buf.appendSlice(alloc, "<UsePreviousValue>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</UsePreviousValue>");
    }
}

pub fn serializeResourceDefinition(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResourceDefinition) !void {
    if (value.logical_resource_id) |v| {
        try buf.appendSlice(alloc, "<LogicalResourceId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</LogicalResourceId>");
    }
    try buf.appendSlice(alloc, "<ResourceIdentifier>");
    try serializeResourceIdentifierProperties(alloc, buf, value.resource_identifier, "entry");
    try buf.appendSlice(alloc, "</ResourceIdentifier>");
    try buf.appendSlice(alloc, "<ResourceType>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.resource_type);
    try buf.appendSlice(alloc, "</ResourceType>");
}

pub fn serializeResourceLocation(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResourceLocation) !void {
    try buf.appendSlice(alloc, "<LogicalResourceId>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.logical_resource_id);
    try buf.appendSlice(alloc, "</LogicalResourceId>");
    try buf.appendSlice(alloc, "<StackName>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.stack_name);
    try buf.appendSlice(alloc, "</StackName>");
}

pub fn serializeResourceMapping(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResourceMapping) !void {
    try buf.appendSlice(alloc, "<Destination>");
    try serializeResourceLocation(alloc, buf, value.destination);
    try buf.appendSlice(alloc, "</Destination>");
    try buf.appendSlice(alloc, "<Source>");
    try serializeResourceLocation(alloc, buf, value.source);
    try buf.appendSlice(alloc, "</Source>");
}

pub fn serializeResourceToImport(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ResourceToImport) !void {
    try buf.appendSlice(alloc, "<LogicalResourceId>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.logical_resource_id);
    try buf.appendSlice(alloc, "</LogicalResourceId>");
    try buf.appendSlice(alloc, "<ResourceIdentifier>");
    try serializeResourceIdentifierProperties(alloc, buf, value.resource_identifier, "entry");
    try buf.appendSlice(alloc, "</ResourceIdentifier>");
    try buf.appendSlice(alloc, "<ResourceType>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.resource_type);
    try buf.appendSlice(alloc, "</ResourceType>");
}

pub fn serializeRollbackConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: RollbackConfiguration) !void {
    if (value.monitoring_time_in_minutes) |v| {
        try buf.appendSlice(alloc, "<MonitoringTimeInMinutes>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MonitoringTimeInMinutes>");
    }
    if (value.rollback_triggers) |v| {
        try buf.appendSlice(alloc, "<RollbackTriggers>");
        try serializeRollbackTriggers(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</RollbackTriggers>");
    }
}

pub fn serializeRollbackTrigger(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: RollbackTrigger) !void {
    try buf.appendSlice(alloc, "<Arn>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.arn);
    try buf.appendSlice(alloc, "</Arn>");
    try buf.appendSlice(alloc, "<Type>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.type);
    try buf.appendSlice(alloc, "</Type>");
}

pub fn serializeScanFilter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ScanFilter) !void {
    if (value.types) |v| {
        try buf.appendSlice(alloc, "<Types>");
        try serializeResourceTypeFilters(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</Types>");
    }
}

pub fn serializeScannedResourceIdentifier(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: ScannedResourceIdentifier) !void {
    try buf.appendSlice(alloc, "<ResourceIdentifier>");
    try serializeJazzResourceIdentifierProperties(alloc, buf, value.resource_identifier, "entry");
    try buf.appendSlice(alloc, "</ResourceIdentifier>");
    try buf.appendSlice(alloc, "<ResourceType>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.resource_type);
    try buf.appendSlice(alloc, "</ResourceType>");
}

pub fn serializeStackDefinition(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StackDefinition) !void {
    if (value.stack_name) |v| {
        try buf.appendSlice(alloc, "<StackName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</StackName>");
    }
    if (value.template_body) |v| {
        try buf.appendSlice(alloc, "<TemplateBody>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TemplateBody>");
    }
    if (value.template_url) |v| {
        try buf.appendSlice(alloc, "<TemplateURL>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TemplateURL>");
    }
}

pub fn serializeStackInstanceFilter(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StackInstanceFilter) !void {
    if (value.name) |v| {
        try buf.appendSlice(alloc, "<Name>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</Name>");
    }
    if (value.values) |v| {
        try buf.appendSlice(alloc, "<Values>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</Values>");
    }
}

pub fn serializeStackSetOperationPreferences(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: StackSetOperationPreferences) !void {
    if (value.concurrency_mode) |v| {
        try buf.appendSlice(alloc, "<ConcurrencyMode>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</ConcurrencyMode>");
    }
    if (value.failure_tolerance_count) |v| {
        try buf.appendSlice(alloc, "<FailureToleranceCount>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</FailureToleranceCount>");
    }
    if (value.failure_tolerance_percentage) |v| {
        try buf.appendSlice(alloc, "<FailureTolerancePercentage>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</FailureTolerancePercentage>");
    }
    if (value.max_concurrent_count) |v| {
        try buf.appendSlice(alloc, "<MaxConcurrentCount>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MaxConcurrentCount>");
    }
    if (value.max_concurrent_percentage) |v| {
        try buf.appendSlice(alloc, "<MaxConcurrentPercentage>");
        {
            const num_str = std.fmt.allocPrint(alloc, "{d}", .{v}) catch "";
            try buf.appendSlice(alloc, num_str);
        }
        try buf.appendSlice(alloc, "</MaxConcurrentPercentage>");
    }
    if (value.region_concurrency_type) |v| {
        try buf.appendSlice(alloc, "<RegionConcurrencyType>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</RegionConcurrencyType>");
    }
    if (value.region_order) |v| {
        try buf.appendSlice(alloc, "<RegionOrder>");
        try serializeRegionList(alloc, buf, v, "member");
        try buf.appendSlice(alloc, "</RegionOrder>");
    }
}

pub fn serializeTag(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tag) !void {
    try buf.appendSlice(alloc, "<Key>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.key);
    try buf.appendSlice(alloc, "</Key>");
    try buf.appendSlice(alloc, "<Value>");
    try aws.xml.appendXmlEscaped(alloc, buf, value.value);
    try buf.appendSlice(alloc, "</Value>");
}

pub fn serializeTemplateConfiguration(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TemplateConfiguration) !void {
    if (value.deletion_policy) |v| {
        try buf.appendSlice(alloc, "<DeletionPolicy>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</DeletionPolicy>");
    }
    if (value.update_replace_policy) |v| {
        try buf.appendSlice(alloc, "<UpdateReplacePolicy>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</UpdateReplacePolicy>");
    }
}

pub fn serializeTemplateSummaryConfig(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TemplateSummaryConfig) !void {
    if (value.treat_unrecognized_resource_types_as_warnings) |v| {
        try buf.appendSlice(alloc, "<TreatUnrecognizedResourceTypesAsWarnings>");
        try buf.appendSlice(alloc, if (v) "true" else "false");
        try buf.appendSlice(alloc, "</TreatUnrecognizedResourceTypesAsWarnings>");
    }
}

pub fn serializeTypeConfigurationIdentifier(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TypeConfigurationIdentifier) !void {
    if (value.type) |v| {
        try buf.appendSlice(alloc, "<Type>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</Type>");
    }
    if (value.type_arn) |v| {
        try buf.appendSlice(alloc, "<TypeArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TypeArn>");
    }
    if (value.type_configuration_alias) |v| {
        try buf.appendSlice(alloc, "<TypeConfigurationAlias>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TypeConfigurationAlias>");
    }
    if (value.type_configuration_arn) |v| {
        try buf.appendSlice(alloc, "<TypeConfigurationArn>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TypeConfigurationArn>");
    }
    if (value.type_name) |v| {
        try buf.appendSlice(alloc, "<TypeName>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TypeName>");
    }
}

pub fn serializeTypeFilters(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: TypeFilters) !void {
    if (value.category) |v| {
        try buf.appendSlice(alloc, "<Category>");
        try buf.appendSlice(alloc, @tagName(v));
        try buf.appendSlice(alloc, "</Category>");
    }
    if (value.publisher_id) |v| {
        try buf.appendSlice(alloc, "<PublisherId>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</PublisherId>");
    }
    if (value.type_name_prefix) |v| {
        try buf.appendSlice(alloc, "<TypeNamePrefix>");
        try aws.xml.appendXmlEscaped(alloc, buf, v);
        try buf.appendSlice(alloc, "</TypeNamePrefix>");
    }
}
