===================================
Product Requirements Document (PRD)
===================================

.. _requirements:

This document outlines the product requirements for the AES-128 hardware accelerator IP core.

.. req:: Title
   :id: REQ_AES_001
   :status: Draft
   :last_updated: 2026-11-06

   The IP core shall implement the AES-128 encryption algorithm 
   according to the FIPS PUB 197 standard.

.. req:: Title
   :id: REQ_AES_002
   :status: Draft
   :last_updated: 2026-11-06

   The IP core shall expose an AMBA AXI interface for configuration 
   and data transfer.

.. req:: Title
   :id: REQ_AES_003
   :status: Draft
   :last_updated: 2026-11-06

   The design shall be fully synthesizable using the LibreLane open-source 
   ASIC flow.

.. req:: Title
   :id: REQ_AES_004
   :status: Draft
   :last_updated: 2026-11-06  

   The design shall target the SkyWater 130 nm open-source PDK library.


Product Requirements Document Table
-----------------------------------

.. needtable::
   :filter: "req" in type
   :columns: id, title, status
   :style: table
