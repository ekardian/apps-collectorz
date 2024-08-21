<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE xsl:stylesheet [<!ENTITY nbsp "&#160;">]>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"/>

<xsl:param name="pageheight">200</xsl:param>
<xsl:param name="pagewidth">400</xsl:param>
<xsl:param name="templatetype">view</xsl:param>
<xsl:param name="absolutelinks">true</xsl:param>
<xsl:param name="stylesheet">view_item_details_bios.css</xsl:param>
<xsl:param name="mybasepath"></xsl:param>

<xsl:include href="shared_templates.xsl"/>

<!-- handle myrating field - set stars -->
<xsl:template name="star">
  <xsl:param name="num" select="0"/>
  	<xsl:variable name="rating">
			<xsl:choose>
			   <xsl:when test="contains($num, '%')">
						<xsl:variable name="percentage">			   
			         <xsl:value-of select="substring-before($num,'%')"/>
						</xsl:variable>
						<xsl:value-of select="$percentage div 10"/>
			   </xsl:when>
			   <xsl:otherwise>		
			       <xsl:value-of select="$num"/>
			   </xsl:otherwise>
			</xsl:choose>
	</xsl:variable>
  <xsl:choose>
    <xsl:when test="$templatetype!='exportdetails'">	
      <a href="http://editrating.html"><img src="{$mybasepath}rating{$rating}.png" border="0"/></a>
    </xsl:when>
    <xsl:otherwise>
      <span class="fieldvaluelarge">  
        <xsl:value-of select="$rating"/>*
      </span>
    </xsl:otherwise>    
  </xsl:choose>     
</xsl:template>

<xsl:template name="creditrole">
  <xsl:param name="roleid" select="dfProgrammer"/>
    <xsl:if test="credits/credit[./role[@id=$roleid]]!=''">
      <tr valign="top">
         <td nowrap="1" class="fieldlabel">
           <xsl:value-of select="/gameinfo/gamemetadata/field[@id=$roleid]/@label"/>
         </td>
         <td class="fieldvalue">
            <xsl:for-each select="credits/credit[./role[@id=$roleid]]">
                <xsl:apply-templates select="person"/>
              <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
            </xsl:for-each>
         </td>
      </tr>
    </xsl:if>
</xsl:template>

<xsl:template name="backdropimage">
  <xsl:param name="nameimg" select="''"/>
  <xsl:if test="$templatetype='view' or 'print'">
    <xsl:if test="$nameimg!=''">
      <a href="http://image.html"><img src="file:///{$nameimg}" border="0" style="height:150px;"/></a>
    </xsl:if>
  </xsl:if>
</xsl:template>

<xsl:template name="boxsetcover">
  <xsl:param name="name" select="''"/>

  <xsl:if test="$templatetype='view'">
    <xsl:if test="$name!=''">
    <div id="boxsetcover">
      <a href="http://image.html"><img src="file:///{$name}" border="0" class="coverimage"/></a>
    </div>
    </xsl:if>
  </xsl:if>
</xsl:template>

<xsl:template name="cover">
  <xsl:param name="in_viewhref" select="''"/>
  <xsl:param name="in_cover" select="''"/>
  <xsl:param name="in_id" select="''"/>
  <xsl:param name="in_postfix" select="''"/>

  <xsl:choose>
    <xsl:when test="$templatetype='view'">
       <a href="{$in_viewhref}">
         <img src="file:///{$in_cover}" border="0" class="coverimage"/>
       </a>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
       <xsl:when test="$absolutelinks = 'true'">
         <a href="$in_cover"><img src="file:///{$in_cover}" class="coverimage"/></a>
       </xsl:when>
       <xsl:otherwise>
         <xsl:variable name="extf"><xsl:call-template name="extractfileextension"><xsl:with-param name="filepath" select="$in_cover"/></xsl:call-template></xsl:variable>
<!--Original code for cover-->
        <!--<a href="../images/{$in_id}{$in_postfix}.{$extf}"><img src="../images/{$in_id}{$in_postfix}.{$extf}" class="coverimage"/></a>-->
<!--End Original code for cover-->         
<!--To local cover-->         
         <!--<a href="../images/{$in_id}{$in_postfix}.{$extf}"><img src="../images/{$in_id}{$in_postfix}.{$extf}" class="coverimage"/></a>-->
<!--End to local cover-->
<!--To web cover-->
         <!-- <img src="https://googledrive.com/host/0B4IL_NIjd8oWfk93QmNsRlcycFFjdEVmRzI0cDdJZHpMOXltQ0ZSM1IwT2QxY21mVXBZRkk/{$in_id}{$in_postfix}.{$extf}" class="coverimage"/> -->
         <a href="../images/{$in_id}{$in_postfix}.{$extf}"><img src="../images/{$in_id}{$in_postfix}.{$extf}" class="coverimage"/></a>
<!--End to web cover-->         
       </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="collection_status">
  <xsl:param name="in_listid" select=""/>
  <xsl:param name="in_status" select=""/>

  <xsl:choose>
    <xsl:when test="$templatetype='view'">
      <img src="{$mybasepath}ic_{$in_listid}_24.png" alt="" border="0"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$in_status"/><br/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="imagelink">
  <xsl:param name="in_viewhref" select="''"/>
  <xsl:param name="in_url" select="''"/>
  
	<xsl:variable name="prefix">
  <xsl:choose>
  		<xsl:when test="contains(in_url, 'http://')"></xsl:when>
			<xsl:otherwise>file:///</xsl:otherwise>
  	</xsl:choose>
	</xsl:variable>

  <xsl:choose>
    <xsl:when test="$templatetype='view'">
      <a href="{$in_viewhref}"><img src="{$prefix}{$in_url}" border="0" class="imagefile" /></a>
    </xsl:when>
    <xsl:otherwise>
      <a href="file:///{$in_url}"><img src="file:///{$in_url}" class="imagefile"/></a>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="trailer">
  <xsl:param name="in_url" select="''"/>
	<xsl:variable name="youtubelink">
  <xsl:choose>
  		<xsl:when test="contains($in_url, 'youtube.com/?')">
  			<xsl:value-of select="substring-after($in_url,'youtube.com/?')"/>
  		</xsl:when>
  		<xsl:when test="contains($in_url, 'youtube.com/watch?v=')">
  			<xsl:value-of select="substring-after($in_url,'youtube.com/watch?v=')"/>
  		</xsl:when>  		
  		<xsl:when test="contains($in_url, 'youtu.be/')">
  			<xsl:value-of select="substring-after($in_url,'youtu.be/')"/>
  		</xsl:when>  		
			<xsl:otherwise></xsl:otherwise>
  	</xsl:choose>
	</xsl:variable>
	<object width="300" height="200">
	<param name="movie" value="http://www.youtube.com/v/{$youtubelink}&amp;fs=1"></param>
	<param name="allowFullScreen" value="true"></param>
	<param name="allowscriptaccess" value="always">
	</param>
	<embed src="http://www.youtube.com/v/{$youtubelink}&amp;fs=1" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="300" height="200">
	</embed>
	</object>
</xsl:template>

<xsl:template name="UserImage">
  <xsl:param name="in_viewhref" select=""/>
  <xsl:param name="in_url" select=""/>
  <xsl:param name="in_description" select="description"/>

  <xsl:choose>
    <xsl:when test="$templatetype='view'">
      <a href="{$in_viewhref}"><img src="{$in_url}" border="0" class="imagefile"/></a>
    </xsl:when>
    <xsl:otherwise>
      <a href="file:///{$in_url}"><img src="file:///{$in_url}" class="imagefile"/></a>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- the main template -->
<xsl:template match="/">
  <HEAD>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <LINK rel="StyleSheet" type="text/css" href="{$mybasepath}{$stylesheet}"></LINK>    
    <link rel="icon" type="image/x-icon" href="images/biosfilm.ico" />
    <link rel="stylesheet" href="../css/bootstrap.min.css"/>
    <link rel="stylesheet" href="../css/bootstrap-theme.min.css"/>
    <META http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
    <meta property="og:title" content="Yacuiba - https://info.biosxtreme.net" />
    <meta property="og:url" content="https://apps.biosxtreme.net/" />
    <meta property="og:type" content="website" />
    <meta property="og:description" content="A la venta --> Colección     Películas - Juegos - Apps - Música - Libros - Comics" />
    <meta property="og:image" content="https://apps.biosxtreme.net/images/appsbiosxtreme.jpg" />
    <TITLE>
      <xsl:value-of select="gameinfo/gamelist/game/title"/>
  		<xsl:if test="gameinfo/gamelist/game/subtitle!=''">
        <xsl:text> - </xsl:text>
        <xsl:value-of select="gameinfo/gamelist/game/subtitle"/>
      </xsl:if>    
    </TITLE>
  </HEAD>
  <BODY onload="initPage();">
    <xsl:apply-templates select="gameinfo/navigation"/>
    <xsl:apply-templates select="gameinfo/gamelist"/>    
  </BODY>
</xsl:template>

<xsl:template match="game">

  <xsl:if test="$stylesheet='view_item_details_bios.css'"> 
	 	<xsl:variable name="apos">'</xsl:variable>
		<xsl:variable name="fixedbackdrop">
			<xsl:call-template name="replace-string">
				<xsl:with-param name="text" select="backgroundbackdrop"/>
				<xsl:with-param name="replace" select="$apos"/>				
				<xsl:with-param name="with" select="concat('\', $apos)"/>				
			</xsl:call-template>
		</xsl:variable> 	
	  <xsl:if test="$fixedbackdrop!=''">
	    <style type="text/css">
			body {background:url('<xsl:value-of select="$fixedbackdrop"/>');background-size:100%;background-attachment:fixed;}	    
			</style>
	  </xsl:if>
  </xsl:if>

  <xsl:if test="boxset!=''">
		<div id="boxset" class="opacity">
      <xsl:call-template name="boxsetcover"><xsl:with-param name="name" select="boxset/frontcover"/></xsl:call-template>
      <xsl:call-template name="boxsetcover"><xsl:with-param name="name" select="boxset/backcover"/></xsl:call-template>
			<span class="maintitle"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfBoxSet']/@label"/>:&nbsp;<xsl:value-of select="boxset/displayname"/></span>
      <table class="valuestable" border="0" cellspacing="0" cellpadding="0">
	      <xsl:if test="boxset/upc!=''">
	         <tr valign="top">
	          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfUPC']/@label"/></td>
	          <td class="fieldvalue"><xsl:value-of select="boxset/upc"/></td>
	         </tr>
	      </xsl:if>
	      <xsl:if test="boxset/releasedate!=''">
	         <tr valign="top">
	          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfReleaseDate']/@label"/></td>
	          <td class="fieldvalue"><xsl:value-of select="boxset/releasedate/date"/></td>
	         </tr>
	      </xsl:if>
	      <xsl:if test="boxset/purchasedate!=''">
	         <tr valign="top">
	          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfPurchaseDate']/@label"/></td>
	          <td class="fieldvalue"><xsl:value-of select="boxset/purchasedate/date"/></td>
	         </tr>
	      </xsl:if>
	      <xsl:if test="boxset/purchaseprice!=''">
	         <tr valign="top">
	          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfPurchasePrice']/@label"/></td>
	          <td class="fieldvalue"><xsl:value-of select="boxset/purchaseprice"/></td>
	         </tr>
	      </xsl:if>
	      <xsl:if test="boxset/store!=''">
	         <tr valign="top">
	          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfStore']/@label"/></td>
	          <td class="fieldvalue"><xsl:value-of select="boxset/store/displayname"/></td>
	         </tr>
	      </xsl:if>
	      <xsl:if test="boxset/condition!=''">
	         <tr valign="top">
	          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfCondition']/@label"/></td>
	          <td class="fieldvalue"><xsl:value-of select="boxset/condition/displayname"/></td>
	         </tr>
	      </xsl:if>
	      <xsl:if test="boxset/currentvalue!=''">
	         <tr valign="top">
	          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfCurrentValue']/@label"/></td>
	          <td class="fieldvalue"><xsl:value-of select="boxset/currentvalue"/></td>
	         </tr>
	      </xsl:if>
			</table>
		  <xsl:if test="boxset/notes!=''">
				<div id="notes">
		    <xsl:call-template name="break">
		      <xsl:with-param name="text" select="boxset/notes"/>
		    </xsl:call-template>
				</div>
		  </xsl:if>
		</div>
	<hr/>
  </xsl:if>

  <xsl:choose>    
    <xsl:when test="coverfront!=''">
    <div id="frontcover">
      <xsl:call-template name="cover">
        <xsl:with-param name="in_viewhref">http://front.html</xsl:with-param>
        <xsl:with-param name="in_cover" select="coverfront"/>
        <xsl:with-param name="in_id" select="id"/>
        <xsl:with-param name="in_postfix">f</xsl:with-param>
      </xsl:call-template>
    </div>
    </xsl:when>
    <xsl:otherwise>
	    <div id="frontcover">
	    	<a href="http://searchcover.html">
		    		<img src="{$mybasepath}coverplaceholder.png" border="0" class="coverimage"/>
	    	</a>
	    </div>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:if test="coverback!=''">
    <div id="backcover">
      <xsl:call-template name="cover">
        <xsl:with-param name="in_viewhref">http://back.html</xsl:with-param>
        <xsl:with-param name="in_cover" select="coverback"/>
        <xsl:with-param name="in_id" select="id"/>
        <xsl:with-param name="in_postfix">b</xsl:with-param>
      </xsl:call-template>
    </div>
  </xsl:if>   

<xsl:choose>
<xsl:when test="hardware!='Yes'">
<table border="0" cellpadding="0" cellspacing="0" class="opacity nomargintop">
  <tr><td><div class="maintitle"><xsl:value-of select="title"/>
		    <xsl:if test="subtitle!=''">
            <xsl:text> - </xsl:text>
            <xsl:value-of select="subtitle"/>
          </xsl:if>
          <xsl:if test="releasedate/year!=''">
            <xsl:text></xsl:text>&nbsp;(<xsl:value-of select="releasedate/year"/>)
          </xsl:if></div>
			 <xsl:if test="series!=''">
            <div class="small" style="padding-bottom:4px;"><b>(<xsl:value-of select="series/displayname"/>&nbsp;series)</b></div>
		    </xsl:if>
  </td></tr>
  <tr><td><b><xsl:if test="platform!=''">  						
							<xsl:if test="$templatetype!='exportdetails'">      
					  		<xsl:if test="platform/templateimage!=''"><img><xsl:attribute name="src"><xsl:value-of select="platform/templateimage"/></xsl:attribute></img>&nbsp;</xsl:if>
            	</xsl:if>			
            <xsl:value-of select="platform/displayname"/>
          </xsl:if></b>
  </td></tr>
  <tr><td><b><xsl:if test="genres!=''">
            <xsl:for-each select="genres/genre">
              <xsl:value-of select="displayname"/>
              <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
            </xsl:for-each>
          </xsl:if></b>
  </td></tr>
    <!-- ID Colección-->
  <!--<tr>
    <td>
      <xsl:if test="id!='0'"><span id="indexvalue">ID:&nbsp;#<xsl:value-of select="id"/></span></xsl:if>
    </td>
  </tr>-->
  <!-- Colección estatus - completados -->
  <!--
  <tr><td style="padding-top:10px;">
  				<xsl:if test="collectionstatus !=''">
            <xsl:call-template name="collection_status">
              <xsl:with-param name="in_listid" select="collectionstatus/@listid"/>
              <xsl:with-param name="in_status" select="collectionstatus"/>
            </xsl:call-template>
          </xsl:if>
          <xsl:if test="index!='0'"><span id="indexvalue">#<xsl:value-of select="index"/></span></xsl:if>
          <br /><xsl:if test="myrating >= 0 and myrating!=''">
            <xsl:call-template name="star"><xsl:with-param name="num" select="myrating"/></xsl:call-template>	
          </xsl:if>
          <xsl:if test="completed !=''">
          <br /><span class="small" style="margin-top:2px;"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfCompleted']/@label"/>:&nbsp;<b><xsl:value-of select="completed"/></b></span>
          </xsl:if>
  </td></tr>-->
  <tr><td style="padding-top:8px;">
    <div class="small"><xsl:if test="publisher!=''"><b><xsl:value-of select="publisher/displayname"/></b></xsl:if>
    <xsl:if test="developer!=''">&nbsp;<xsl:value-of select="developer/displayname"/></xsl:if>
	 <br /><xsl:if test="format!=''"><b><xsl:value-of select="format/displayname"/></b></xsl:if><xsl:if test="upc!=''">&nbsp;<xsl:value-of select="upc"/></xsl:if></div>
  </td></tr>
</table>

<br style="clear:both;" />
  <xsl:if test="credits!=''">
    <table class="valuestable opacity" border="0" cellspacing="0" cellpadding="0">
      <xsl:call-template name="creditrole"><xsl:with-param name="roleid">dfProgrammer</xsl:with-param></xsl:call-template>
      <xsl:call-template name="creditrole"><xsl:with-param name="roleid">dfSoundMusic</xsl:with-param></xsl:call-template>
      <xsl:call-template name="creditrole"><xsl:with-param name="roleid">dfGraphics</xsl:with-param></xsl:call-template>
      <xsl:call-template name="creditrole"><xsl:with-param name="roleid">dfProducer</xsl:with-param></xsl:call-template>
      <xsl:call-template name="creditrole"><xsl:with-param name="roleid">dfUserCredit1</xsl:with-param></xsl:call-template>         
      <xsl:call-template name="creditrole"><xsl:with-param name="roleid">dfUserCredit2</xsl:with-param></xsl:call-template>
    </table><br />
  </xsl:if>
  
  
<div style="clear:both;">
<span style="float:left;">
  <xsl:if test="$templatetype='view'">
    <xsl:if test="links!=''">
    <xsl:if test="links//*[urltype='Trailer URL']!=''">
      <div style="float:left;margin-top:2px;width:305px;margin-right:5px;" id="trailers">
            
	     <xsl:for-each select="links//*[urltype='Trailer URL']"><p/>
		    <xsl:call-template name="trailer">        
		      <xsl:with-param name="in_url" select="url"/>
		    </xsl:call-template>
		  </xsl:for-each> 
      </div>
    </xsl:if>
    </xsl:if>
    </xsl:if>
 </span>  
</div>  
  
  <xsl:if test="description!=''">
    <div class="opacity description"><xsl:call-template name="break"><xsl:with-param name="text" select="description"/></xsl:call-template></div>
  </xsl:if>

  <div style="clear:both;">
   <table class="details" width="100%" style="margin-top:3px;" border="0"><tr>
    <td valign="top" width="50%">

    <div id="productdetails" class="marginbackdrop">
      <table class="valuestable opacity" border="0" cellspacing="0" cellpadding="0">
       <tr><td class="header" colspan="2"><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttProductDetails']/@label"/></td></tr>
      <xsl:if test="edition!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfEdition']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="edition/displayname"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="nrdisks!=''">
        <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfNrDisks']/@label" /></td>
          <td class="fieldvalue"><xsl:value-of select="nrdisks"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="multiplayer!=''">
         <tr valign="top">
            <td nowrap="1" class="fieldlabel">
            <xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfMultiplayer']/@label"/>
          </td>
            <td class="fieldvalue">
             <xsl:for-each select="multiplayer/mode">
               <xsl:value-of select="displayname"/>
               <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
             </xsl:for-each>
          </td>
        </tr>
      </xsl:if>    
      <xsl:if test="devices!=''">
         <tr valign="top">
            <td nowrap="1" class="fieldlabel">
            <xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfDevices']/@label"/>
          </td>
            <td class="fieldvalue">
             <xsl:for-each select="devices/device">
               <xsl:value-of select="displayname"/>
               <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
             </xsl:for-each>
          </td>
        </tr>
      </xsl:if>
      <xsl:if test="region!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfRegion']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="region/displayname"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="language!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfLanguage']/@label"/></td>
          <td class="fieldvalue">
						<xsl:if test="$templatetype!='exportdetails'">
					  	<xsl:if test="language/templateimage!=''"><img><xsl:attribute name="src"><xsl:value-of select="language/templateimage"/></xsl:attribute></img>&nbsp;</xsl:if>
			      </xsl:if>          
          	<xsl:value-of select="language/displayname"/>
          </td>
          
         </tr>
      </xsl:if>      
      <xsl:if test="audiencerating!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfAudienceRating']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="audiencerating/displayname"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="systemrequirements!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfSystemRequirements']/@label"/></td>
          <td class="fieldvalue">
          	<xsl:call-template name="break">
		      		<xsl:with-param name="text" select="systemrequirements"/>
		    		</xsl:call-template>
          </td>
         </tr>
      </xsl:if>                 
      <xsl:if test="extras!=''">
         <tr valign="top">
            <td nowrap="1" class="fieldlabel">
              <xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfExtras']/@label"/>
            </td>
            <td class="fieldvalue">
               <xsl:for-each select="extras/extra">
                 <xsl:value-of select="displayname"/>
                 <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
               </xsl:for-each>
            </td>
         </tr>
      </xsl:if>
      <xsl:if test="reviewrating!='0'">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfReviewRating']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="reviewrating"/></td>
         </tr>
      </xsl:if>  
      <xsl:if test="hardwarecategory!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfHardwareCategory']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="hardwarecategory/displayname"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="serialnumber!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfSerialNumber']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="serialnumber"/></td>
         </tr>
      </xsl:if>
      
     </table>
   </div>	

   </td>
   <td valign="top" width="50%">

   <div id="personaldetails"  class="opacity marginbackdrop">
      <table class="valuestable" border="0" cellspacing="0" cellpadding="0">
       <tr><td class="header" colspan="2"><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttPersonalDetails']/@label"/></td></tr>
        <xsl:if test="owner!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfOwner']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="owner/displayname"/></td>
         </tr>
        </xsl:if>
		  <xsl:if test="location!=''">
         <tr valign="top">
<!--Localización-->          
          <!--Reemplazado localización por LCT-->          
          <!--<td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfLocation']/@label"/></td>-->
          <td class="fieldlabel" nowrap="1">LCT</td>
          <td class="fieldvalue"><xsl:value-of select="location/displayname"/></td>
         </tr>
        </xsl:if>
		  <xsl:if test="loan/loanedto!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfLoaner']/@label"/></td>
          <td class="fieldvalue"><xsl:apply-templates select="loan/loanedto"/>&nbsp;@&nbsp;<xsl:value-of select="loan/loandate/date"/></td>
         </tr>
        </xsl:if>
      <xsl:if test="purchasedate!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfPurchaseDate']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="purchasedate/date"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="purchaseprice!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfPurchasePrice']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="purchaseprice"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="store!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfStore']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="store/displayname"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="condition!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfCondition']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="condition/displayname"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="currentvalue!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfCurrentValue']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="currentvalue"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="quantity>'1'">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfQuantity']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="quantity"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="tags!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfTag']/@label"/></td>
          <td class="fieldvalue"><xsl:for-each select="tags/tag">
             <xsl:value-of select="displayname"/>
             <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
           </xsl:for-each></td>
         </tr>
      </xsl:if>
      <xsl:if test="userlookup1!=''"> 
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfUserLookup1']/@label"/></td>
          <td class="fieldvalue"><xsl:apply-templates select="userlookup1"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="userlookup2!=''"> 
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfUserLookup2']/@label"/></td>
          <td class="fieldvalue"><xsl:apply-templates select="userlookup2"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="usertext1!=''"> 
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfUserText1']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="usertext1"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="usertext2!=''"> 
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfUserText2']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="usertext2"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="storagedevice!=''"> 
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfStorageDevice']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="storagedevice/displayname"/>&nbsp;/&nbsp;<xsl:value-of select="storageslot"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="links!=''">
        <xsl:if test="links//*[urltype='URL']!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfLinks']/@label"/></td>
          <td class="fieldvalue">
            <xsl:apply-templates select="links//*[urltype='URL']"/>
          </td>
         </tr>
        </xsl:if> 
        <xsl:if test="links//*[urltype='Trailer']!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1">Trailer Links</td>
          <td class="fieldvalue">
            <xsl:apply-templates select="links//*[urltype='Trailer']"/>
          </td>
         </tr>
        </xsl:if>         
        <xsl:if test="$absolutelinks = 'true'">
        <xsl:if test="(links//*[urltype='Movie']!='')">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfMovieLinks']/@label"/></td>
          <td class="fieldvalue">
            <xsl:apply-templates select="(links//*[urltype='Movie'])"/>
          </td>
         </tr>
        </xsl:if>
        <xsl:if test="(links//*[urltype='Other']!='')">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfOtherLinks']/@label"/></td>
          <td class="fieldvalue">
            <xsl:apply-templates select="(links//*[urltype='Other'])"/>
          </td>
         </tr>
        </xsl:if>        
        </xsl:if>
      </xsl:if>
     </table>
   </div>

  </td></tr></table></div>
</xsl:when>
<xsl:otherwise>
<table border="0" cellpadding="0" cellspacing="0" class="opacity">
  <tr><td><div class="maintitle"><xsl:value-of select="title"/>
		    <xsl:if test="subtitle!=''">
            <xsl:text> - </xsl:text>
            <xsl:value-of select="subtitle"/>
          </xsl:if>
          <xsl:if test="releasedate/year!=''">
            <xsl:text></xsl:text>&nbsp;(<xsl:value-of select="releasedate/year"/>)
          </xsl:if></div>
  </td></tr>
  <tr><td><b><xsl:if test="platform!=''">
							<xsl:if test="$templatetype!='exportdetails'">      
					  		<xsl:if test="platform/templateimage!=''"><img><xsl:attribute name="src"><xsl:value-of select="platform/templateimage"/></xsl:attribute></img>&nbsp;</xsl:if>
            	</xsl:if>	  
            	<xsl:value-of select="platform/displayname"/>
          </xsl:if></b>
  </td></tr>
  <tr><td style="padding-top:10px;">
  				<xsl:if test="collectionstatus !=''">
            <xsl:call-template name="collection_status">
              <xsl:with-param name="in_listid" select="collectionstatus/@listid"/>
              <xsl:with-param name="in_status" select="collectionstatus"/>
            </xsl:call-template>
          </xsl:if>
          <xsl:if test="index!='0'"><span id="indexvalue">#<xsl:value-of select="index"/></span></xsl:if>
          <br /><xsl:if test="myrating >= 0 and myrating!=''">
            <xsl:call-template name="star"><xsl:with-param name="num" select="myrating"/></xsl:call-template>	
          </xsl:if>
          <br />
  </td></tr>
  <tr><td style="padding-top:8px;">
    <div class="small">
	 <br /><xsl:if test="upc!=''">&nbsp;<xsl:value-of select="upc"/></xsl:if></div>
  </td></tr>
</table>
  <xsl:if test="coverback!=''">
    <div id="backcover">
      <xsl:call-template name="cover">
        <xsl:with-param name="in_viewhref">http://back.html</xsl:with-param>
        <xsl:with-param name="in_cover" select="coverback"/>
        <xsl:with-param name="in_id" select="id"/>
        <xsl:with-param name="in_postfix">b</xsl:with-param>
      </xsl:call-template>
    </div>
  </xsl:if> 

<br style="clear:both;" />
  <xsl:if test="description!=''">
    <div class="description"><xsl:call-template name="break"><xsl:with-param name="text" select="description"/></xsl:call-template></div>
  </xsl:if>

  <div style="clear:both;">
   <table class="details" width="100%" border="0"><tr>
   <td valign="top" width="50%">

   <div id="personaldetails">
      <table class="valuestable opacity" border="0" cellspacing="0" cellpadding="0">
       <tr><td class="header" colspan="2"><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttPersonalDetails']/@label"/></td></tr>
        <xsl:if test="owner!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfOwner']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="owner/displayname"/></td>
         </tr>
        </xsl:if>
		  <xsl:if test="location!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfLocation']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="location/displayname"/></td>
         </tr>
        </xsl:if>
		  <xsl:if test="loan/loanedto!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfLoaner']/@label"/></td>
          <td class="fieldvalue"><xsl:apply-templates select="loan/loanedto"/>&nbsp;@&nbsp;<xsl:value-of select="loan/loandate/date"/></td>
         </tr>
        </xsl:if>
      <xsl:if test="purchasedate!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfPurchaseDate']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="purchasedate/date"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="purchaseprice!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfPurchasePrice']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="purchaseprice"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="store!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfStore']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="store/displayname"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="condition!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfCondition']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="condition/displayname"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="currentvalue!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfCurrentValue']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="currentvalue"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="quantity>'1'">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfQuantity']/@label"/></td>
          <td class="fieldvalue"><xsl:value-of select="quantity"/></td>
         </tr>
      </xsl:if>
      <xsl:if test="links!=''">
        <xsl:if test="links//*[urltype='URL']!=''">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfLinks']/@label"/></td>
          <td class="fieldvalue">
            <xsl:apply-templates select="links//*[urltype='URL']"/>
          </td>
         </tr>
        </xsl:if>  
        <xsl:if test="$absolutelinks = 'true'">
        <xsl:if test="(links//*[urltype='Movie']!='')">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfMovieLinks']/@label"/></td>
          <td class="fieldvalue">
            <xsl:apply-templates select="(links//*[urltype='Movie'])"/>
          </td>
         </tr>
        </xsl:if>
        <xsl:if test="(links//*[urltype='Other']!='')">
         <tr valign="top">
          <td class="fieldlabel" nowrap="1"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfOtherLinks']/@label"/></td>
          <td class="fieldvalue">
            <xsl:apply-templates select="(links//*[urltype='Other'])"/>
          </td>
         </tr>
        </xsl:if>        
        </xsl:if>
      </xsl:if>
     </table>
   </div>

  </td></tr></table></div>
</xsl:otherwise>
</xsl:choose>

    <xsl:if test="$absolutelinks = 'true'">
    <xsl:if test="links!=''">
      <xsl:if test="links//*[urltype='Image']!=''">
      <br/><div id="imagefiles">
        <span class="header"><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttImageLinkScreenShots']/@label"/></span>
        <div>
          <xsl:for-each select="links//*[urltype='Image']">
            <xsl:call-template name="UserImage">
              <xsl:with-param name="in_viewhref">http://image.html</xsl:with-param>
              <xsl:with-param name="in_url" select="url"/>
              <xsl:with-param name="in_description" select="description"/>
            </xsl:call-template>
          </xsl:for-each>
        </div>
      </div>
      </xsl:if>
      </xsl:if>
    </xsl:if>
    
    <xsl:if test="$absolutelinks = 'true'">
    	<xsl:if test="links!=''">
	      <xsl:if test="links//*[urltype='Other Image']!=''">
		      <br/><div id="imagefiles">
		        <div class="header"><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttImageLinkDetails']/@label"/></div>
		        <div>
		          <xsl:for-each select="links//*[urltype='Other Image']">
		            <xsl:call-template name="UserImage">
		              <xsl:with-param name="in_viewhref">http://image.html</xsl:with-param>
		              <xsl:with-param name="in_url" select="url"/>
		              <xsl:with-param name="in_description" select="description"/>
		            </xsl:call-template>
		          </xsl:for-each>
		        </div>
		      </div>
	      </xsl:if>
      </xsl:if>
    </xsl:if>    
    
		<xsl:if test="$templatetype!='exportdetails'">
			<xsl:if test="backdropurl!=''">
			  <div style="float:left;margin-right:5px;margin-top:5px;">
			    <div class="header opacity" style="font-size:10pt;">Backdrop</div>	
					  <xsl:call-template name="backdropimage">
					    <xsl:with-param name="nameimg" select="backdropurl"/>
					  </xsl:call-template>
			  </div>
			</xsl:if>
		</xsl:if>
	
    <xsl:if test="notes!=''">
      <div id="notes" class="opacity">
        <div class="header"><xsl:value-of select="/gameinfo/gamemetadata/field[@id='dfNotes']/@label"/></div>
        <xsl:call-template name="break">
          <xsl:with-param name="text" select="notes"/>
        </xsl:call-template>
      </div>
    </xsl:if>
	      
		<xsl:if test="position()!=last()">
		  <p style="page-break-before: always"/>
		</xsl:if>  
		
</xsl:template>

<!--
<xsl:template match="navigation">
  <div align="center">
  <div class="navigation" align="center">
    <div class="navigationline">
      <xsl:choose>
        <xsl:when test="firstlink/@url!=''">
          <div class="navlink" id="first"><a href="{firstlink/@url}"><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttFirst']/@label"/></a></div>
        </xsl:when>
        <xsl:otherwise>
          <div class="navlink" id="first"><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttFirst']/@label"/></div>
        </xsl:otherwise>
      </xsl:choose>   
      <xsl:choose>
        <xsl:when test="prevlink/@url!=''">
          <div class="navlink" id="prev"><a href="{prevlink/@url}"><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttPrev']/@label"/></a></div>
        </xsl:when>
        <xsl:otherwise>
          <div class="navlink" id="prev"><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttPrev']/@label"/></div>
        </xsl:otherwise>
      </xsl:choose>   
      <xsl:choose>
        <xsl:when test="uplink/@url!=''">
          <div class="navlink" id="up"><a href="{uplink/@url}"><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttUp']/@label"/></a></div>
        </xsl:when>
        <xsl:otherwise>
          <div class="navlink" id="up"><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttUp']/@label"/></div>
        </xsl:otherwise>
      </xsl:choose>   
      <xsl:choose>
        <xsl:when test="nextlink/@url!=''">
          <div class="navlink" id="next"><a href="{nextlink/@url}"><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttNext']/@label"/></a></div>
        </xsl:when>
        <xsl:otherwise>
          <div class="navlink" id="next"><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttNext']/@label"/></div>
        </xsl:otherwise>
      </xsl:choose>   
      <xsl:choose>
        <xsl:when test="lastlink/@url!=''">
          <div class="navlink" id="last"><a href="{lastlink/@url}"><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttLast']/@label"/></a></div>
        </xsl:when>
        <xsl:otherwise>
          <div class="navlink" id="last"><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttLast']/@label"/></div>
        </xsl:otherwise>
      </xsl:choose>   
    </div>
  </div>
  </div>
</xsl:template>
-->
<xsl:template match="navigation">
  <nav class="text-center">
  <ul class="pagination">
      <xsl:choose>
        <xsl:when test="firstlink/@url!=''">
          <li><a href="{firstlink/@url}"><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttFirst']/@label"/></a></li>
        </xsl:when>
        <xsl:otherwise>
          <li><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttFirst']/@label"/></li>
        </xsl:otherwise>
      </xsl:choose>   
      <xsl:choose>
        <xsl:when test="prevlink/@url!=''">
          <li><a href="{prevlink/@url}"><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttPrev']/@label"/></a></li>
        </xsl:when>
        <xsl:otherwise>
          <li><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttPrev']/@label"/></li>
        </xsl:otherwise>
      </xsl:choose>   
      <xsl:choose>
        <xsl:when test="uplink/@url!=''">
          <li><a href="{uplink/@url}"><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttUp']/@label"/></a></li>
        </xsl:when>
        <xsl:otherwise>
          <li><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttUp']/@label"/></li>
        </xsl:otherwise>
      </xsl:choose>   
      <xsl:choose>
        <xsl:when test="nextlink/@url!=''">
          <li><a href="{nextlink/@url}"><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttNext']/@label"/></a></li>
        </xsl:when>
        <xsl:otherwise>
          <li><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttNext']/@label"/></li>
        </xsl:otherwise>
      </xsl:choose>   
      <xsl:choose>
        <xsl:when test="lastlink/@url!=''">
          <li><a href="{lastlink/@url}"><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttLast']/@label"/></a></li>
        </xsl:when>
        <xsl:otherwise>
          <li><xsl:value-of select="/gameinfo/localizedtemplatetexts/field[@id='ttLast']/@label"/></li>
        </xsl:otherwise>
      </xsl:choose>
  </ul>
  </nav>
</xsl:template>

</xsl:stylesheet>
