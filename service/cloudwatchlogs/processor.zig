const AddKeys = @import("add_keys.zig").AddKeys;
const CopyValue = @import("copy_value.zig").CopyValue;
const CSV = @import("csv.zig").CSV;
const DateTimeConverter = @import("date_time_converter.zig").DateTimeConverter;
const DeleteKeys = @import("delete_keys.zig").DeleteKeys;
const Grok = @import("grok.zig").Grok;
const ListToMap = @import("list_to_map.zig").ListToMap;
const LowerCaseString = @import("lower_case_string.zig").LowerCaseString;
const MoveKeys = @import("move_keys.zig").MoveKeys;
const ParseCloudfront = @import("parse_cloudfront.zig").ParseCloudfront;
const ParseJSON = @import("parse_json.zig").ParseJSON;
const ParseKeyValue = @import("parse_key_value.zig").ParseKeyValue;
const ParsePostgres = @import("parse_postgres.zig").ParsePostgres;
const ParseRoute53 = @import("parse_route_53.zig").ParseRoute53;
const ParseToOCSF = @import("parse_to_ocsf.zig").ParseToOCSF;
const ParseVPC = @import("parse_vpc.zig").ParseVPC;
const ParseWAF = @import("parse_waf.zig").ParseWAF;
const RenameKeys = @import("rename_keys.zig").RenameKeys;
const SplitString = @import("split_string.zig").SplitString;
const SubstituteString = @import("substitute_string.zig").SubstituteString;
const TrimString = @import("trim_string.zig").TrimString;
const TypeConverter = @import("type_converter.zig").TypeConverter;
const UpperCaseString = @import("upper_case_string.zig").UpperCaseString;

/// This structure contains the information about one processor in a log
/// transformer.
pub const Processor = struct {
    /// Use this parameter to include the [
    /// addKeys](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-addKeys) processor in your transformer.
    add_keys: ?AddKeys,

    /// Use this parameter to include the [
    /// copyValue](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-copyValue) processor in your transformer.
    copy_value: ?CopyValue,

    /// Use this parameter to include the [
    /// CSV](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-CSV) processor in your transformer.
    csv: ?CSV,

    /// Use this parameter to include the [
    /// datetimeConverter](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-datetimeConverter) processor in your transformer.
    date_time_converter: ?DateTimeConverter,

    /// Use this parameter to include the [
    /// deleteKeys](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-deleteKeys) processor in your transformer.
    delete_keys: ?DeleteKeys,

    /// Use this parameter to include the [
    /// grok](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-grok) processor in your transformer.
    grok: ?Grok,

    /// Use this parameter to include the [
    /// listToMap](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-listToMap) processor in your transformer.
    list_to_map: ?ListToMap,

    /// Use this parameter to include the [
    /// lowerCaseString](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-lowerCaseString) processor in your transformer.
    lower_case_string: ?LowerCaseString,

    /// Use this parameter to include the [
    /// moveKeys](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-moveKeys) processor in your transformer.
    move_keys: ?MoveKeys,

    /// Use this parameter to include the [
    /// parseCloudfront](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-parseCloudfront) processor in your transformer.
    ///
    /// If you use this processor, it must be the first processor in your
    /// transformer.
    parse_cloudfront: ?ParseCloudfront,

    /// Use this parameter to include the [
    /// parseJSON](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-parseJSON) processor in your transformer.
    parse_json: ?ParseJSON,

    /// Use this parameter to include the [
    /// parseKeyValue](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-parseKeyValue) processor in your transformer.
    parse_key_value: ?ParseKeyValue,

    /// Use this parameter to include the [
    /// parsePostGres](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-parsePostGres) processor in your transformer.
    ///
    /// If you use this processor, it must be the first processor in your
    /// transformer.
    parse_postgres: ?ParsePostgres,

    /// Use this parameter to include the [
    /// parseRoute53](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-parseRoute53) processor in your transformer.
    ///
    /// If you use this processor, it must be the first processor in your
    /// transformer.
    parse_route_53: ?ParseRoute53,

    /// Use this parameter to convert logs into Open Cybersecurity Schema (OCSF)
    /// format.
    parse_to_ocsf: ?ParseToOCSF,

    /// Use this parameter to include the [
    /// parseVPC](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-parseVPC) processor in your transformer.
    ///
    /// If you use this processor, it must be the first processor in your
    /// transformer.
    parse_vpc: ?ParseVPC,

    /// Use this parameter to include the [
    /// parseWAF](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-parseWAF) processor in your transformer.
    ///
    /// If you use this processor, it must be the first processor in your
    /// transformer.
    parse_waf: ?ParseWAF,

    /// Use this parameter to include the [
    /// renameKeys](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-renameKeys) processor in your transformer.
    rename_keys: ?RenameKeys,

    /// Use this parameter to include the [
    /// splitString](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-splitString) processor in your transformer.
    split_string: ?SplitString,

    /// Use this parameter to include the [
    /// substituteString](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-substituteString) processor in your transformer.
    substitute_string: ?SubstituteString,

    /// Use this parameter to include the [
    /// trimString](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-trimString) processor in your transformer.
    trim_string: ?TrimString,

    /// Use this parameter to include the [
    /// typeConverter](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-typeConverter) processor in your transformer.
    type_converter: ?TypeConverter,

    /// Use this parameter to include the [
    /// upperCaseString](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-upperCaseString) processor in your transformer.
    upper_case_string: ?UpperCaseString,

    pub const json_field_names = .{
        .add_keys = "addKeys",
        .copy_value = "copyValue",
        .csv = "csv",
        .date_time_converter = "dateTimeConverter",
        .delete_keys = "deleteKeys",
        .grok = "grok",
        .list_to_map = "listToMap",
        .lower_case_string = "lowerCaseString",
        .move_keys = "moveKeys",
        .parse_cloudfront = "parseCloudfront",
        .parse_json = "parseJSON",
        .parse_key_value = "parseKeyValue",
        .parse_postgres = "parsePostgres",
        .parse_route_53 = "parseRoute53",
        .parse_to_ocsf = "parseToOCSF",
        .parse_vpc = "parseVPC",
        .parse_waf = "parseWAF",
        .rename_keys = "renameKeys",
        .split_string = "splitString",
        .substitute_string = "substituteString",
        .trim_string = "trimString",
        .type_converter = "typeConverter",
        .upper_case_string = "upperCaseString",
    };
};
