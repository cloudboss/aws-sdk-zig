package software.amazon.smithy.zig

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test

class NamingUtilTest {
    @Test
    fun camelCase() {
        assertEquals("camel_case", NamingUtil.toSnakeCase("camelCase"))
    }

    @Test
    fun pascalCase() {
        assertEquals("pascal_case", NamingUtil.toSnakeCase("PascalCase"))
    }

    @Test
    fun acronymAtStart() {
        assertEquals("iam_role", NamingUtil.toSnakeCase("IAMRole"))
    }

    @Test
    fun acronymInMiddle() {
        assertEquals("get_ec2_instance", NamingUtil.toSnakeCase("GetEC2Instance"))
    }

    @Test
    fun acronymAtEnd() {
        assertEquals("use_iam", NamingUtil.toSnakeCase("UseIAM"))
    }

    @Test
    fun digitBoundary() {
        assertEquals("level_2_thing", NamingUtil.toSnakeCase("Level2Thing"))
    }

    @Test
    fun alreadySnakeCase() {
        assertEquals("already_snake", NamingUtil.toSnakeCase("already_snake"))
    }

    @Test
    fun singleWord() {
        assertEquals("word", NamingUtil.toSnakeCase("Word"))
    }

    @Test
    fun empty() {
        assertEquals("", NamingUtil.toSnakeCase(""))
    }

    @Test
    fun toZigFileName() {
        assertEquals("my_struct.zig", NamingUtil.toZigFileName("MyStruct"))
    }

    @Test
    fun hyphenated() {
        assertEquals("kebab_case", NamingUtil.toSnakeCase("kebab-case"))
    }

    @Test
    fun testSnakeCaseV2Pattern() {
        assertEquals("list_objects_v2", NamingUtil.toSnakeCase("ListObjectsV2"))
        assertEquals("list_objects_v3", NamingUtil.toSnakeCase("ListObjectsV3"))
        assertEquals("get_object", NamingUtil.toSnakeCase("GetObject"))
        assertEquals("put_bucket_acl", NamingUtil.toSnakeCase("PutBucketACL"))
        assertEquals("create_multipart_upload", NamingUtil.toSnakeCase("CreateMultipartUpload"))
    }
}
