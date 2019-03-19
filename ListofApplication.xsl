<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
  <html>
  <body>
    <table border="1">
      <tr bgcolor="#9acd32">
        <th>Name</th>
        <th>Url</th>
      </tr>
      <xsl:for-each select="applications/application">
      <tr>
        <td><xsl:value-of select="@Name"/></td>
        <td><xsl:value-of select="@url"/></td>
      </tr>
      </xsl:for-each>
    </table>
  </body>
  </html>
</xsl:template>
</xsl:stylesheet>

