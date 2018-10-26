<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="{$charset}" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{if $kbarticle.title}{$kbarticle.title} - {/if}{$pagetitle} - {$companyname}</title>

    {include file="$template/includes/head.tpl"}

    {$headoutput}

</head>
<body data-phone-cc-input="{$phoneNumberInputStyle}">

{$headeroutput}
<div class="top-bar">
  <ul class="nav top-nav justify-content-end">
      {if $languagechangeenabled && count($locales) > 1}
          <li>
              <a href="#" class="choose-language" data-toggle="popover" id="languageChooser">
                  {$activeLocale.localisedName}
                  <b class="caret"></b>
              </a>
              <div id="languageChooserContent" class="hidden">
                  <ul>
                      {foreach $locales as $locale}
                          <li>
                              <a href="{$currentpagelinkback}language={$locale.language}">{$locale.localisedName}</a>
                          </li>
                      {/foreach}
                  </ul>
              </div>
          </li>
      {/if}
      {if $loggedin}
          <li>
              <a href="#" data-toggle="popover" id="accountNotifications" data-placement="bottom">
                  {$LANG.notifications}
                  {if count($clientAlerts) > 0}
                      <span class="label label-info">{lang key='notificationsnew'}</span>
                  {/if}
                  <b class="caret"></b>
              </a>
              <div id="accountNotificationsContent" class="hidden">
                  <ul class="client-alerts">
                  {foreach $clientAlerts as $alert}
                      <li>
                          <a href="{$alert->getLink()}">
                              <i class="fas fa-fw fa-{if $alert->getSeverity() == 'danger'}exclamation-circle{elseif $alert->getSeverity() == 'warning'}exclamation-triangle{elseif $alert->getSeverity() == 'info'}info-circle{else}check-circle{/if}"></i>
                              <div class="message">{$alert->getMessage()}</div>
                          </a>
                      </li>
                  {foreachelse}
                      <li class="none">
                          {$LANG.notificationsnone}
                      </li>
                  {/foreach}
                  </ul>
              </div>
          </li>
          <li>
              <a href="{$WEB_ROOT}/logout.php" class="btn">
                  {$LANG.clientareanavlogout}
              </a>
          </li>
      {else}
          <li>
              <a href="{$WEB_ROOT}/clientarea.php">{$LANG.login}</a>
          </li>
          {if $condlinks.allowClientRegistration}
              <li>
                  <a href="{$WEB_ROOT}/register.php">{$LANG.register}</a>
              </li>
          {/if}
          <li>
              <a href="{$WEB_ROOT}/cart.php?a=view" class="btn">
                  {$LANG.viewcart}
              </a>
          </li>
      {/if}
      {if $adminMasqueradingAsClient || $adminLoggedIn}
          <li>
              <a href="{$WEB_ROOT}/logout.php?returntoadmin=1" class="btn btn-logged-in-admin" data-toggle="tooltip" data-placement="bottom" title="{if $adminMasqueradingAsClient}{$LANG.adminmasqueradingasclient} {$LANG.logoutandreturntoadminarea}{else}{$LANG.adminloggedin} {$LANG.returntoadminarea}{/if}">
                  <i class="fas fa-sign-out-alt"></i>
              </a>
          </li>
      {/if}
  </ul>
</div>
<section id="header">
    <div class="container">
        {if $assetLogoPath}
            <a href="{$WEB_ROOT}/index.php" class="logo"><img src="{$assetLogoPath}" alt="{$companyname}"></a>
        {else}
            <a href="{$WEB_ROOT}/index.php" class="logo logo-text">{$companyname}</a>
        {/if}

    </div>
</section>

<section id="main-menu">
  <nav id="nav" class="navbar navbar-expand-lg navbar-main" role="navigation">
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="primary-nav">
        <ul class="navbar-nav nav">

            {include file="$template/includes/navbar.tpl" navbar=$primaryNavbar}

        </ul>

        <ul class="navbar-nav ml-auto">

            {include file="$template/includes/navbar.tpl" navbar=$secondaryNavbar}

        </ul>
      </div>
    </nav>
</section>

{if $templatefile == 'homepage'}
    <section id="home-banner">
        <div class="container text-center">
            {if $registerdomainenabled || $transferdomainenabled}
                <h2>{$LANG.homebegin}</h2>
                <form method="post" action="domainchecker.php">
                    <div class="row">
                        <div class="col-md-8 offset-md-2 col-sm-10 offset-sm-1">
                            <div class="input-group input-group-lg">
                              <input type="text" class="form-control" name="domain" placeholder="{$LANG.exampledomain}" autocapitalize="none">
                              <div class="input-group-append" id="button-addon4">
                                {if $registerdomainenabled}
                                    <input type="submit" class="btn btn-outline-secondary search" value="{$LANG.search}" />
                                {/if}
                                {if $transferdomainenabled}
                                    <input type="submit" name="transfer" class="btn btn-outline-secondary transfer" value="{$LANG.domainstransfer}" />
                                {/if}
                              </div>
                            </div>
                        </div>
                    </div>

                    {include file="$template/includes/captcha.tpl"}
                </form>
            {else}
                <h2>{$LANG.doToday}</h2>
            {/if}
        </div>
    </section>
    <div class="home-shortcuts">
        <div class="container">
            <div class="row">
                <div class="col-md-4 hidden-sm hidden-xs text-center">
                    <p class="lead">
                        {$LANG.howcanwehelp}
                    </p>
                </div>
                <div class="col-sm-12 col-md-8">
                    <ul>
                        {if $registerdomainenabled || $transferdomainenabled}
                            <li>
                                <a id="btnBuyADomain" href="domainchecker.php">
                                    <i class="fas fa-globe"></i>
                                    <p>
                                        {$LANG.buyadomain} <span>&raquo;</span>
                                    </p>
                                </a>
                            </li>
                        {/if}
                        <li>
                            <a id="btnOrderHosting" href="cart.php">
                                <i class="far fa-hdd"></i>
                                <p>
                                    {$LANG.orderhosting} <span>&raquo;</span>
                                </p>
                            </a>
                        </li>
                        <li>
                            <a id="btnMakePayment" href="clientarea.php">
                                <i class="fas fa-credit-card"></i>
                                <p>
                                    {$LANG.makepayment} <span>&raquo;</span>
                                </p>
                            </a>
                        </li>
                        <li>
                            <a id="btnGetSupport" href="submitticket.php">
                                <i class="far fa-envelope"></i>
                                <p>
                                    {$LANG.getsupport} <span>&raquo;</span>
                                </p>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
{/if}

{include file="$template/includes/verifyemail.tpl"}

<section id="main-body">
    <div class="container{if $skipMainBodyContainer}-fluid without-padding{/if}">
        <div class="row">

        {if !$inShoppingCart && ($primarySidebar->hasChildren() || $secondarySidebar->hasChildren())}
            {if $primarySidebar->hasChildren() && !$skipMainBodyContainer}
                <div class="col-md-9 pull-md-right">
                    {include file="$template/includes/pageheader.tpl" title=$displayTitle desc=$tagline showbreadcrumb=true}
                </div>
            {/if}
            <div class="col-md-3 pull-md-left sidebar">
                {include file="$template/includes/sidebar.tpl" sidebar=$primarySidebar}
            </div>
        {/if}
        <!-- Container for main page display content -->
        <div class="{if !$inShoppingCart && ($primarySidebar->hasChildren() || $secondarySidebar->hasChildren())}col-md-9 pull-md-right{else}col-xs-12{/if} main-content">
            {if !$primarySidebar->hasChildren() && !$showingLoginPage && !$inShoppingCart && $templatefile != 'homepage' && !$skipMainBodyContainer}
                {include file="$template/includes/pageheader.tpl" title=$displayTitle desc=$tagline showbreadcrumb=true}
            {/if}
